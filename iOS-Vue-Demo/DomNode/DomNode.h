//
//  DomNode.h
//  iOS-Vue-Demo
//
//  Created by youxiaobin on 2020/8/30.
//  Copyright © 2020 youxiaobin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DomAttribute.h"
#import "DomStyle.h"


typedef NS_ENUM(NSInteger, DomNodeType) {
    DomNodeTypeView,
    DomNodeTypeLabel,
    DomNodeTypeButton,
    DomNodeTypeImageView
};
NS_INLINE DomNodeType _ConvertStringToType(NSString *value) {
    if([value isEqualToString:@"div"]) return DomNodeTypeView;
    else if([value isEqualToString:@"image"] || [value isEqualToString:@"img"]) return DomNodeTypeImageView;
    else if([value isEqualToString:@"label"] || [value isEqualToString:@"text"]) return DomNodeTypeLabel;
    else if([value isEqualToString:@"button"]) return DomNodeTypeButton;
    else return DomNodeTypeView;
}

NS_ASSUME_NONNULL_BEGIN

@interface DomNode : NSObject
/// DomNode的标识符
@property (nonatomic, copy)NSString *ref;
/// 节点的类型(这里暂时定义四种,满足Demo的需要就可以了)
@property (nonatomic, assign)DomNodeType type;
/// 节点的渲染属性,需要在渲染的时候展示出来的(其中有一部分是与布局属性重合的:即在布局属性里面也需要在渲染属性里面)
@property (nonatomic, strong)DomAttribute *attribute;
/// 节点的布局属性,用于Flex布局计算
@property (nonatomic, strong)DomStyle *style;
/// 父节点
@property (nonatomic, weak)DomNode *parent;
/// 子节点
@property (nonatomic, strong)NSMutableArray<DomNode *> *children;
@property (nonatomic, strong)NSArray<NSString *> *events;
@property (nonatomic, assign, getter=isDirty, readonly) BOOL dirty;
@property (nonatomic, assign, readonly)CGSize size;
@property (nonatomic, assign, readonly)CGPoint point;
@property (nonatomic, assign, readonly)CGRect rect;

- (instancetype)init NS_UNAVAILABLE;
+ (instancetype)new NS_UNAVAILABLE;
- (instancetype)initWithRef:(NSString *)ref
                       type:(DomNodeType)type
                  attribute:(DomAttribute *)attribute
                      style:(DomStyle *)style
                     events:(NSArray<NSString *> *)events;

- (void)appendNode:(DomNode *)node;
- (void)fill;
- (void)makeDirty;
- (YGNodeRef)getYGNode;
- (BOOL)requireUpdate;
@end

NS_ASSUME_NONNULL_END
