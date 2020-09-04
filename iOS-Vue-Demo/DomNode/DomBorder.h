//
//  DomBorder.h
//  iOS-Vue-Demo
//
//  Created by youxiaobin on 2020/8/30.
//  Copyright © 2020 youxiaobin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface DomBorder : NSObject
@property (nonatomic, copy)NSString *color;
@property (nonatomic, copy)NSString *style;
@property (nonatomic, assign)CGFloat width;
- (instancetype)initWithBorderContent:(NSString *)borderContent;
@end

NS_ASSUME_NONNULL_END
