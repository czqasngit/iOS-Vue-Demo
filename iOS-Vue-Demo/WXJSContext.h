//
//  WXJSContext.h
//  iOS-Vue-Demo
//
//  Created by youxiaobin on 2020/8/22.
//  Copyright © 2020 youxiaobin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DomNode.h"
NS_ASSUME_NONNULL_BEGIN

@protocol WXJSContextDelegate <NSObject>
- (void)buildNodeCompleted;
@end
@interface WXJSContext : NSObject
@property (nonatomic, weak)id<WXJSContextDelegate> delegate;
- (instancetype)initWithDelegate:(id<WXJSContextDelegate>)delegate;
- (void)start;
- (DomNode *)getRootNode;
- (void)sendEvent:(NSString *)ref event:(NSString *)event;
- (BOOL)requireUpdate;
@end

NS_ASSUME_NONNULL_END
