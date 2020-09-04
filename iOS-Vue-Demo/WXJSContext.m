//
//  WXJSContext.m
//  iOS-Vue-Demo
//
//  Created by youxiaobin on 2020/8/22.
//  Copyright © 2020 youxiaobin. All rights reserved.
//

#import "WXJSContext.h"
#import <JavaScriptCore/JavaScriptCore.h>
#import "DomNode.h"
/// 提取JSValue中的属性名称
NS_INLINE NSArray *ExtractPropertyNamesFromJSValue(JSValue *jsValue) {
    NSMutableArray *keys = NULL;
    JSContextRef contextRef = jsValue.context.JSGlobalContextRef;
    JSValueRef exception = NULL;
    JSObjectRef jsObjectRef = JSValueToObject(contextRef, jsValue.JSValueRef, &exception);
    if(exception != NULL) {
        NSLog(@"JSValueToObject Exception");
        return @[];
    }
    BOOL somethingWrong = NO;
    if (jsObjectRef != NULL) {
        JSPropertyNameArrayRef allKeyRefs = JSObjectCopyPropertyNames(contextRef, jsObjectRef);
        size_t keyCount = JSPropertyNameArrayGetCount(allKeyRefs);
        
        keys = [[NSMutableArray alloc] initWithCapacity:keyCount];
        for (size_t i = 0; i < keyCount; i ++) {
            JSStringRef nameRef = JSPropertyNameArrayGetNameAtIndex(allKeyRefs, i);
            size_t len = JSStringGetMaximumUTF8CStringSize(nameRef);
            if (len > 1024) {
                somethingWrong = YES;
                break;
            }
            char* buf = (char*)malloc(len + 5);
            if (buf == NULL) {
                somethingWrong = YES;
                break;
            }
            bzero(buf, len + 5);
            if (JSStringGetUTF8CString(nameRef, buf, len + 5) > 0) {
                NSString* keyString = [NSString stringWithUTF8String:buf];
                if ([keyString length] == 0) {
                    somethingWrong = YES;
                    free(buf);
                    break;
                }
                [keys addObject:keyString];
            }
            else {
                somethingWrong = YES;
                free(buf);
                break;
            }
            free(buf);
        }
        JSPropertyNameArrayRelease(allKeyRefs);
    } else {
        somethingWrong = YES;
    }
    if (somethingWrong) {
        // may contain retain-cycle.
        keys = (NSMutableArray*)[[jsValue toDictionary] allKeys];
    }
    return keys;
}

NS_INLINE DomNode *_FindNodeByRef(NSString *ref, DomNode *target) {
    if(!ref) return NULL;
    if([target.ref isEqualToString:ref]) return target;
    if(target.children.count > 0) {
        for(DomNode *child in target.children) {
            DomNode *n = _FindNodeByRef(ref, child);
            if(n) return n;
        }
    }
    return NULL;
}


@interface WXJSContext()
@property (nonatomic, strong)JSContext *context;
@property (nonatomic, strong)DomNode *rootNode;
@end
@implementation WXJSContext

- (instancetype)initWithDelegate:(id<WXJSContextDelegate>)delegate {
    self = [super init];
    if (self) {
        _delegate = delegate;
        self.context = [[JSContext alloc] init];
        [self _setupConsoleLog];
        [self _setupWxJSFramework];
        [self _hookCallNative];
        [self _prepareVueEnvironment];
    }
    return self;
}

#pragma mark - Private
- (void)_setupConsoleLog {
    _context[@"console"][@"log"] = ^(NSString *message) {
        NSLog(@"Javascript log: %@",message);
    };
}
- (void)_setupWxJSFramework {
    NSString *path = [[NSBundle mainBundle] pathForResource:@"js-framework" ofType:@"js"];
    NSError *error;
    NSString *code = [[NSString alloc] initWithContentsOfFile:path encoding:NSUTF8StringEncoding error:&error];
    [_context evaluateScript:code];
}
- (void)_prepareVueEnvironment {
    /// 加载完js-framework后就会在global object上挂载一系列的方法
    /// 通过调用global object的createInstanceContext,传递参数为实例的标识符,这里是"1"
    /// 创建好p实例上下文后,通过这个实例可以拿到Vue的具体定义
    /// 将Vue的定义挂载到global object上就可以成加载模板代码时,使用到Vue时找到
    JSGlobalContextRef globalContextRef = _context.JSGlobalContextRef;
    JSObjectRef globalObjectRef = JSContextGetGlobalObject(globalContextRef);
    JSValue *v = [[_context globalObject] invokeMethod:@"createInstanceContext" withArguments:@[@"1"]];
    NSArray *keys = ExtractPropertyNamesFromJSValue(v);
    for(NSString *key in keys) {
        if([key isEqualToString:@"Vue"]) {
            /// 获取全局对象globalObject的prototype(原型链)
            JSValueRef valueRef = JSObjectGetPrototype(globalContextRef, globalObjectRef);
            /// 将Vue的值转化成一个Vue对象
            JSObjectRef objectRef = JSValueToObject(globalContextRef, [v valueForProperty:key].JSValueRef, NULL);
            /// 在Vue的原型链上增加globalObject
            JSObjectSetPrototype(globalContextRef, objectRef, valueRef);
        }
        JSStringRef propertyName = JSStringCreateWithUTF8CString([key cStringUsingEncoding:NSUTF8StringEncoding]);
        JSObjectSetProperty(globalContextRef, globalObjectRef, propertyName, [v valueForProperty:key].JSValueRef, 0, NULL);
    }
}
- (void)_hookCallNative {
    __weak typeof(self) _ws = self;
    _context[@"callNative"] = ^(JSValue *a, JSValue *b) {
        __strong typeof(_ws) _ss = _ws;
        if([a isString] && [b isObject]) {
            NSString *instanceId = [a toString];
            NSData *data = [NSJSONSerialization dataWithJSONObject:[b toDictionary] options:NSJSONWritingFragmentsAllowed error:NULL];
            NSString *info = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
            NSLog(@"实例id: %@, 数据: %@", instanceId, info);
            NSDictionary *_data = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:NULL];
            [_ss _handleCallNativeCallback:instanceId data:_data];
        }
    };
}
- (void)_loadBundleJSCode {
    NSString *codePath = [[NSBundle mainBundle] pathForResource:@"wx.bundle" ofType:@"js"];
    NSString *code = [[NSString alloc] initWithContentsOfFile:codePath encoding:NSUTF8StringEncoding error:NULL];
    [_context evaluateScript:code];
}
#pragma mark -

- (void)_addNodeTo:(NSString *)ref child:(DomNode *)child {
    DomNode *node = _FindNodeByRef(ref, _rootNode);
    if(node) {
        child.parent = node;
        [node appendNode:child];
    }
}

#pragma mark - CallNative CallBack
- (void)_handleCallNativeCallback:(NSString *)instanceId data:(NSDictionary * _Nonnull)data {
    if(!data) return;
    NSDictionary *info = data[@"0"];
    if(!info || ![info isKindOfClass:[NSDictionary class]]) return;
    NSString *method = info[@"method"];
    if(method.length == 0) return;
    if([method isEqualToString:@"createBody"]) {
        [self _createBody:instanceId data:info];
    } else if([method isEqualToString:@"addElement"]) {
        [self _addElement:instanceId data:info];
    } else if([method isEqualToString:@"updateAttrs"]) {
        [self _updateAttrs:info];
    } else if([method isEqualToString:@"updateStyle"]) {
        [self _updateStyles:info];
    } else if([method isEqualToString:@"createFinish"]) {
        [self _createFinished];
    } else {
        NSLog(@"data: %@", data);
    }
}

- (void)_createBody:(NSString *)instanceId data:(NSDictionary *)data {
    if(!data || ![data isKindOfClass:[NSDictionary class]]) return;
    NSArray<NSDictionary *> *args = data[@"args"];
    if(!args || ![args isKindOfClass:[NSArray class]]) return;
    if(args.count == 0) return;
    NSDictionary *domProperty = args[0];
    NSString *ref = domProperty[@"ref"];
    DomNodeType type = _ConvertStringToType(domProperty[@"type"]);
    DomStyle *style = [[DomStyle alloc] initWithData:domProperty[@"style"]];
    DomAttribute *attribute = [[DomAttribute alloc] initWithData:domProperty[@"attr"]];
    [attribute updateAttributeWithData:domProperty[@"style"]];
    NSArray<NSString *> *events = domProperty[@"event"];
    DomNode *node = [[DomNode alloc] initWithRef:ref type:type attribute:attribute style:style events:events];
    _rootNode = node;
}
- (void)_addElement:(NSString *)instanceId data:(NSDictionary *)data {
    if(!data || ![data isKindOfClass:[NSDictionary class]]) return;
    NSArray *args = data[@"args"];
    if(!args || ![args isKindOfClass:[NSArray class]]) return;
    if(args.count < 2) return;
    NSString *parentNodeRef = args[0];
    NSDictionary *domProperty = args[1];
    NSString *ref = domProperty[@"ref"];
    DomNodeType type = _ConvertStringToType(domProperty[@"type"]);
    DomStyle *style = [[DomStyle alloc] initWithData:domProperty[@"style"]];
    DomAttribute *attribute = [[DomAttribute alloc] initWithData:domProperty[@"attr"]];
    [attribute updateAttributeWithData:domProperty[@"style"]];
    NSArray<NSString *> *events = domProperty[@"event"];
    DomNode *node = [[DomNode alloc] initWithRef:ref type:type attribute:attribute style:style events:events];
    [self _addNodeTo:parentNodeRef child:node];
}
- (void)_updateAttrs:(NSDictionary *)data {
    if(!data || ![data isKindOfClass:[NSDictionary class]]) return;
    NSArray *args = data[@"args"];
    if(!args || ![args isKindOfClass:[NSArray class]]) return;
    if(args.count < 2) return;
    NSString *ref = args[0];
    NSDictionary *domProperty = args[1];
    DomNode *node = _FindNodeByRef(ref, _rootNode);
    [node.attribute updateAttributeWithData:domProperty];
    [node makeDirty];
}
- (void)_updateStyles:(NSDictionary *)data {
    if(!data || ![data isKindOfClass:[NSDictionary class]]) return;
    NSArray *args = data[@"args"];
    if(!args || ![args isKindOfClass:[NSArray class]]) return;
    if(args.count < 2) return;
    NSString *ref = args[0];
    NSDictionary *domProperty = args[1];
    DomNode *node = _FindNodeByRef(ref, _rootNode);
    [node.style updateStyleWithData:domProperty];
}
- (void)_createFinished {
    if([_delegate respondsToSelector:@selector(buildNodeCompleted)]) {
        [_delegate buildNodeCompleted];
    }
}

#pragma mark - Public
- (void)start {
    [self _loadBundleJSCode];
}
- (DomNode *)getRootNode {
    return _rootNode;
}
- (void)sendEvent:(NSString *)ref event:(NSString *)event {
    NSLog(@"IOS Context收到事件: %@, %@", ref, event);
    NSDictionary *params = @{
        @"module": @"",
        @"method": @"fireEvent",
        @"args": @[
            ref,
            event
        ]
    };
    NSArray *args = @[@"1", @[params]];
    [[_context globalObject] invokeMethod:@"__WEEX_CALL_JAVASCRIPT__" withArguments:args];
}
- (BOOL)requireUpdate {
    return [_rootNode requireUpdate];
}
@end
