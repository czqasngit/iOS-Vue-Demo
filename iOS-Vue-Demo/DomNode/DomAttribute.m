//
//  DomAttribute.m
//  iOS-Vue-Demo
//
//  Created by youxiaobin on 2020/8/30.
//  Copyright © 2020 youxiaobin. All rights reserved.
//

#import "DomAttribute.h"

static NSDictionary<NSString *, NSString *> *_ColorTable;
NS_INLINE NSString *_FixColor(NSString *colorValue) {
    if(!_ColorTable) {
        _ColorTable = @{
                  @"black": @"#000000",
                  @"silver": @"#C0C0C0",
                  @"gray": @"#808080",
                  @"white": @"#FFFFFF",
                  @"maroon": @"#800000",
                  @"red": @"#FF0000",
                  @"purple": @"#800080",
                  @"fuchsia": @"#FF00FF",
                  @"green": @"#008000",
                  
                  @"lime": @"#00FF00",
                  @"olive": @"#808000",
                  @"yellow": @"#FFFF00",
                  @"navy": @"#000080",
                  @"blue": @"#0000FF",
                  @"teal": @"#008080",
                  @"aqua": @"#00FFFF",
                  @"darkred": @"#8B0000",
                  @"pink": @"#FFC0CB"
        };
    }
    if(_ColorTable[colorValue]) return _ColorTable[colorValue];
    return colorValue;
}
@implementation DomAttribute
- (instancetype)initWithData:(NSDictionary *)data {
    self = [super init];
    if (self) {
        _fontSize = 15;
        _maxNumberLine = 1;
        _color = @"#000000";
        _backgroundColor = @"#FFFFFF";
        [self _setupWithData:data];
    }
    return self;
}

#pragma mark - Private
- (void)_setupWithData:(NSDictionary *)data {
    [self updateAttributeWithData:data];
}
- (void)updateAttributeWithData:(NSDictionary *)data {
    if(!data) return;
    if(data[@"color"]) {
        _backgroundColor = _FixColor(data[@"color"]);
    }
    if(data[@"backgroundColor"]) {
        _backgroundColor = _FixColor(data[@"backgroundColor"]);
    }
    if(data[@"fontSize"]) {
        _fontSize = [data[@"fontSize"] integerValue];
    }
    if(data[@"value"]) {
        _value = data[@"value"];
    }
    if(data[@"src"]) {
        _imageNamed = data[@"src"];
    }
}
@end
