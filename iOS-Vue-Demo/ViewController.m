//
//  ViewController.m
//  iOS-Vue-Demo
//
//  Created by youxiaobin on 2020/8/22.
//  Copyright © 2020 youxiaobin. All rights reserved.
//

#import "ViewController.h"
#import "WXJSContext.h"
#import "DomNode.h"
#import "DomAttribute.h"
#import "UIColor+Hex.h"
#import <objc/runtime.h>

@interface UIView(_DomNode)
@property (nonatomic, strong)DomNode *node;
@end
@implementation UIView(_DomNode)
- (void)setNode:(DomNode *)node {
    objc_setAssociatedObject(self, _cmd, node, OBJC_ASSOCIATION_RETAIN);
}
- (DomNode *)node {
    return objc_getAssociatedObject(self, @selector(setNode:));
}
@end

@interface ViewController ()<WXJSContextDelegate>
@property (nonatomic, strong)WXJSContext *wxJSCtx;
@property (nonatomic, strong)CADisplayLink *nodeDisplayLink;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _nodeDisplayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(_displayLink)];
    [_nodeDisplayLink addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];
    self.wxJSCtx = [[WXJSContext alloc] initWithDelegate:self];
    [self.wxJSCtx start];
    self.view.backgroundColor = [UIColor orangeColor];
}
- (void)_displayLink {
    if([_wxJSCtx requireUpdate]) {
        [self buildNodeCompleted];
    }
}
- (void)_render:(DomNode *)node superView:(UIView *)superView {
    if(!node) return;
    for(DomNode *child in node.children) {
        UIView *childView = NULL;
        if(child.type == DomNodeTypeLabel) {
            UILabel *label = [[UILabel alloc] init];
            label.font = [UIFont systemFontOfSize:child.attribute.fontSize];
            label.textColor = [UIColor colorWithHexString:child.attribute.color alpha:1.0f];
            label.text = child.attribute.value;
            childView = label;
        } else if(child.type == DomNodeTypeView) {
            UIView *view = [[UIView alloc] init];
            view.backgroundColor = [UIColor colorWithHexString:child.attribute.backgroundColor alpha:1.0f];
            childView = view;
        } else if(child.type == DomNodeTypeButton) {
            UIButton *button = [[UIButton alloc] init];
            [button setTitle:child.attribute.value forState:UIControlStateNormal];
            [button setTitleColor:[UIColor colorWithHexString:child.attribute.color alpha:1.0f] forState:UIControlStateNormal];
            button.titleLabel.font = [UIFont systemFontOfSize:child.attribute.fontSize];
            childView = button;
        }
        childView.frame = child.rect;
        childView.backgroundColor = [UIColor colorWithHexString:child.attribute.backgroundColor alpha:1.0f];
        [superView addSubview:childView];
        childView.node = child;
        if(child.events.count > 0) {
            for(NSString *event in child.events) {
                if([event isEqualToString:@"click"]) {
                    childView.userInteractionEnabled = YES;
                    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(_clickEvent:)];
                    [childView addGestureRecognizer:tap];
                }
            }
        }
        
        if(child.children.count > 0) {
            [self _render:child superView:childView];
        }
    }
}
- (void)_clickEvent:(UITapGestureRecognizer *)sender {
    NSLog(@"点击");
    DomNode *node = sender.view.node;
    if(!node) return;
    [self.wxJSCtx sendEvent:node.ref event:@"click"];
}
#pragma mark - WXJSContextDelegate
- (void)buildNodeCompleted {
    DomNode *rootNode = [self.wxJSCtx getRootNode];
    if(!rootNode) return;
    NSLog(@"开始计算布局");
    [rootNode fill];
    YGNodeRef ygNode = [rootNode getYGNode];
    if(!ygNode) return;
    CGSize screenSize = self.view.bounds.size;
    YGNodeCalculateLayout(ygNode, screenSize.width, screenSize.height, YGNodeStyleGetDirection(ygNode));
    NSLog(@"布局完成,开始渲染");
    
    NSAssert(rootNode.type == DomNodeTypeView, @"root view 必须是DomNodeTypeView");
    UIView *_oldRootView = [self.view viewWithTag:9527];
    if(_oldRootView) {
        [_oldRootView removeFromSuperview];
    }
    UIView *rootView = [[UIView alloc] init];
    rootView.tag = 9527;
    rootView.backgroundColor = [UIColor colorWithHexString:rootNode.attribute.backgroundColor alpha:1.0f];
    rootView.frame = rootNode.rect;
    [self.view addSubview:rootView];
    
    [self _render:rootNode superView:rootView];
    NSLog(@"渲染完成");
}

@end
