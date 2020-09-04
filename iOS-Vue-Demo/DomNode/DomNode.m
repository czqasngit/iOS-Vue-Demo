//
//  DomNode.m
//  iOS-Vue-Demo
//
//  Created by youxiaobin on 2020/8/30.
//  Copyright © 2020 youxiaobin. All rights reserved.
//

#import "DomNode.h"
#import "Yoga.h"

YGSize __YGMeasureFunc(YGNodeRef ygNode,
                       float width,
                       YGMeasureMode widthMode,
                       float height,
                       YGMeasureMode heightMode) {
    DomNode *node = (__bridge DomNode *)YGNodeGetContext(ygNode);
    if(node.type == DomNodeTypeLabel) {
        DomAttribute *attribute = node.attribute;
        UIFont *font = NULL;
        if(attribute.fontFamily) {
            NSString *fontName = attribute.fontFamily;
            font = [UIFont fontWithName:fontName size:attribute.fontSize];
        } else {
            font = [UIFont systemFontOfSize:attribute.fontSize];
        }
        NSString *text = attribute.value;
        CGSize size = [text boundingRectWithSize:CGSizeMake((CGFloat)width, (CGFloat)height)
                                         options:NSStringDrawingUsesLineFragmentOrigin
                                      attributes:@{NSFontAttributeName: font}
                                         context:NULL].size;
        NSInteger maxNumberLine = attribute.maxNumberLine;
        float h = maxNumberLine > 0 ? MIN(ceil(font.lineHeight * maxNumberLine), ceil((float)size.height)) : ceil((float)size.height);
        return (YGSize){ceil((float)size.width), h};
    }
    return (YGSize){ .width = 0, .height = 0 };
}


@interface DomNode() {
    YGNodeRef _ygNode;
}
@end
@implementation DomNode
- (void)dealloc {
    YGNodeFree(_ygNode);
}
- (instancetype)initWithRef:(NSString *)ref
                       type:(DomNodeType)type
                  attribute:(DomAttribute *)attribute
                      style:(DomStyle *)style
                     events:(NSArray<NSString *> *)events {
    self = [super init];
    if(self) {
        _ref = ref;
        _type = type;
        _attribute = attribute;
        _style = style;
        _children = [[NSMutableArray alloc] init];
        _events = events;
        _ygNode = YGNodeNew();
        if(type == DomNodeTypeLabel) {
            YGNodeSetContext(_ygNode, (__bridge void *)self);
            YGNodeSetMeasureFunc(_ygNode, __YGMeasureFunc);
        }
    }
    return self;
}
#pragma mark - Public
- (void)appendNode:(DomNode *)node {
    [_children addObject:node];
    YGNodeInsertChild(_ygNode, [node getYGNode], YGNodeGetChildCount(_ygNode));
}
- (void)fill {
    [self.style fill:_ygNode];
    for(DomNode *child in _children) {
        [child fill];
    }
    _dirty = NO;
}
- (void)makeDirty {
    _dirty = YES;
    YGNodeMarkDirty(_ygNode);
}
- (YGNodeRef)getYGNode {
    return _ygNode;
}
- (CGSize)size {
    return (CGSize){
        .width = YGNodeLayoutGetWidth(_ygNode),
        .height = YGNodeLayoutGetHeight(_ygNode)
    };
}
- (CGPoint)point {
    return (CGPoint){
        .x = YGNodeLayoutGetLeft(_ygNode),
        .y = YGNodeLayoutGetTop(_ygNode)
    };
}
- (CGRect)rect {
    return (CGRect) {
        .origin = (CGPoint)self.point,
        .size = (CGSize)self.size
    };
}
- (BOOL)requireUpdate {
    if(self.isDirty) return YES;
    for(DomNode *child in _children) {
        if([child requireUpdate]) {
            return YES;
        }
    }
    return NO;
}
@end
