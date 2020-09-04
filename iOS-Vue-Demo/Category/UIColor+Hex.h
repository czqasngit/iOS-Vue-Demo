//
//  UIColor+Hex.h
//  iOS-Vue-Demo
//
//  Created by youxiaobin on 2020/8/30.
//  Copyright © 2020 youxiaobin. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIColor (Hex)
+ (UIColor *)colorWithHexString:(NSString *)color alpha:(CGFloat)alpha;
@end

NS_ASSUME_NONNULL_END
