//
//  DomAttribute.h
//  iOS-Vue-Demo
//
//  Created by youxiaobin on 2020/8/30.
//  Copyright © 2020 youxiaobin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DomBorder.h"

NS_ASSUME_NONNULL_BEGIN

@interface DomAttribute : NSObject
@property (nonatomic, strong) NSString *color;
@property (nonatomic, strong) NSString *backgroundColor;
@property (nonatomic, assign) NSInteger fontSize;
@property (nonatomic, strong) NSString *fontFamily;
@property (nonatomic, strong) NSString *value;
@property (nonatomic, strong) NSString *imageNamed;
@property (nonatomic, assign) NSInteger maxNumberLine;
@property (nonatomic, strong) DomBorder *border;

- (instancetype)initWithData:(NSDictionary *)data;
- (void)updateAttributeWithData:(NSDictionary * _Nullable)data;
@end

NS_ASSUME_NONNULL_END
