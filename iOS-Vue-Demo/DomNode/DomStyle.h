//
//  DomStyle.h
//  iOS-Vue-Demo
//
//  Created by youxiaobin on 2020/8/30.
//  Copyright © 2020 youxiaobin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "Yoga.h"
#import "DomEdge.h"
#import "DomBorder.h"

NS_ASSUME_NONNULL_BEGIN

@interface DomStyle : NSObject
@property (nonatomic, assign) YGDirection direction;
@property (nonatomic, assign) YGFlexDirection flexDirection;
@property (nonatomic, assign) YGJustify justifyContent;
@property (nonatomic, assign) YGAlign alignSelf;
@property (nonatomic, assign) YGAlign alignItems;
@property (nonatomic, assign) YGPositionType positionType;
@property (nonatomic, assign) YGWrap flexWrap;
@property (nonatomic, assign) YGOverflow overflow;
@property (nonatomic, assign) YGDisplay display;
@property (nonatomic, assign) int flex;
@property (nonatomic, assign) int flexGrow;
@property (nonatomic, assign) int flexShrink;
@property (nonatomic, assign) DomEdge position;
@property (nonatomic, assign) DomEdge margin;
@property (nonatomic, assign) DomEdge padding;
@property (nonatomic, strong) DomBorder *border;
@property (nonatomic, assign) CGFloat height;
@property (nonatomic, assign) CGFloat width;
@property (nonatomic, assign) CGFloat maxWidth;
@property (nonatomic, assign) CGFloat minWidth;
@property (nonatomic, assign) CGFloat maxHeight;
@property (nonatomic, assign) CGFloat minHeight;

- (instancetype)initWithData:(NSDictionary *)data;
- (void)updateStyleWithData:(NSDictionary * _Nullable)data;
- (void)fill:(YGNodeRef)ygNode;
@end

NS_ASSUME_NONNULL_END
