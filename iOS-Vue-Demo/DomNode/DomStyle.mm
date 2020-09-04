//
//  DomStyle.m
//  iOS-Vue-Demo
//
//  Created by youxiaobin on 2020/8/30.
//  Copyright © 2020 youxiaobin. All rights reserved.
//

#import "DomStyle.h"

NS_INLINE YGDirection _GetDirection(NSString *direction) {
    if([direction isEqualToString:@"inherit"]) return YGDirectionInherit;
    else if([direction isEqualToString:@"ltr"]) return YGDirectionLTR;
    else if([direction isEqualToString:@"rtl"]) return YGDirectionRTL;
    else {
        return YGDirectionInherit;
    }
}
NS_INLINE YGFlexDirection _GetFlexDirection(NSString *flexDirection) {
    if([flexDirection isEqualToString:@"column"]) return YGFlexDirectionColumn;
    else if([flexDirection isEqualToString:@"Row"]) return YGFlexDirectionRow;
    else if([flexDirection isEqualToString:@"columnReverse"]) return YGFlexDirectionColumnReverse;
    else if([flexDirection isEqualToString:@"rowReverse"]) return YGFlexDirectionRowReverse;
    else {
        return YGFlexDirectionRow;
    }
}
NS_INLINE YGJustify _GetJustifyContent(NSString *justifyContent) {
    if([justifyContent isEqualToString:@"center"]) return YGJustifyCenter;
    else if([justifyContent isEqualToString:@"flexStart"]) return YGJustifyFlexStart;
    else if([justifyContent isEqualToString:@"flexEnd"]) return YGJustifyFlexEnd;
    else if([justifyContent isEqualToString:@"spaceBetween"]) return YGJustifySpaceBetween;
    else if([justifyContent isEqualToString:@"spaceAround"]) return YGJustifySpaceAround;
    else if([justifyContent isEqualToString:@"spaceEvenly"]) return YGJustifySpaceEvenly;
    else {
        return YGJustifyFlexStart;
    }
}
NS_INLINE YGAlign _GetAlignSelf(NSString *alignSelf) {
    if([alignSelf isEqualToString:@"auto"]) return YGAlignAuto;
    else if([alignSelf isEqualToString:@"flexStart"]) return YGAlignFlexStart;
    else if([alignSelf isEqualToString:@"flexEnd"]) return YGAlignFlexEnd;
    else if([alignSelf isEqualToString:@"center"]) return YGAlignCenter;
    else if([alignSelf isEqualToString:@"stretch"]) return YGAlignStretch;
    else if([alignSelf isEqualToString:@"baseline"]) return YGAlignBaseline;
    else if([alignSelf isEqualToString:@"spaceBetween"]) return YGAlignSpaceBetween;
    else if([alignSelf isEqualToString:@"spaceAround"]) return YGAlignSpaceAround;
    else {
        return YGAlignFlexStart;
    }
}
NS_INLINE YGAlign _GetAlignItems(NSString *alignItems) {
    if([alignItems isEqualToString:@"auto"]) return YGAlignAuto;
    else if([alignItems isEqualToString:@"flexStart"]) return YGAlignFlexStart;
    else if([alignItems isEqualToString:@"flexEnd"]) return YGAlignFlexEnd;
    else if([alignItems isEqualToString:@"center"]) return YGAlignCenter;
    else if([alignItems isEqualToString:@"stretch"]) return YGAlignStretch;
    else if([alignItems isEqualToString:@"baseline"]) return YGAlignBaseline;
    else if([alignItems isEqualToString:@"spaceBetween"]) return YGAlignSpaceBetween;
    else if([alignItems isEqualToString:@"spaceAround"]) return YGAlignSpaceAround;
    else {
        return YGAlignFlexStart;
    }
}
NS_INLINE YGPositionType _GetPositionType(NSString *positionType) {
    if([positionType isEqualToString:@"relative"]) return YGPositionTypeRelative;
    else if([positionType isEqualToString:@"absolute"]) return YGPositionTypeAbsolute;
    else {
        return YGPositionTypeRelative;
    }
}
NS_INLINE YGWrap _GetWrap(NSString *wrap) {
    if([wrap isEqualToString:@"nowrap"]) return YGWrapNoWrap;
    else if([wrap isEqualToString:@"wrap"]) return YGWrapWrap;
    else if([wrap isEqualToString:@"wrapReverse"]) return YGWrapWrapReverse;
    else {
        return YGWrapNoWrap;
    }
}
NS_INLINE YGOverflow _GetOverflow(NSString *overflow) {
    if([overflow isEqualToString:@"visible"]) return YGOverflowVisible;
    else if([overflow isEqualToString:@"hidden"]) return YGOverflowHidden;
    else if([overflow isEqualToString:@"scroll"]) return YGOverflowScroll;
    else {
        return YGOverflowHidden;
    }
}
NS_INLINE YGDisplay _GetDisplay(NSString *display) {
    if([display isEqualToString:@"flex"]) return YGDisplayFlex;
    else if([display isEqualToString:@"none"]) return YGDisplayNone;
    else {
        return YGDisplayFlex;
    }
}

using namespace std;
@implementation DomStyle
- (instancetype)initWithData:(NSDictionary *)data {
    self = [super init];
    if (self) {
        [self _setupDefaultValue];
        [self _setupWithData:data];
    }
    return self;
}
#pragma mark - Private
- (void)_setupDefaultValue {
    _direction = YGDirectionInherit;
    _flexDirection = YGFlexDirectionRow;
    _justifyContent = YGJustifyFlexStart;
    _alignSelf = YGAlignAuto;
    _alignItems = YGAlignFlexStart;
    _positionType = YGPositionTypeRelative;
    _flexWrap = YGWrapNoWrap;
    _overflow = YGOverflowVisible;
    _display = YGDisplayFlex;
    _flex = std::numeric_limits<float>::quiet_NaN();
    _flexGrow = 0;
    _flexShrink = 0;
    _position = {-1};
    _margin = {-1};
    _padding = {-1};
    _height = -1;
    _width = -1;
    _maxWidth = -1;
    _minWidth = -1;
    _maxHeight = -1;
    _minHeight = -1;
}
- (void)_setupWithData:(NSDictionary *)data {
    [self updateStyleWithData:data];
}

#pragma mark - Public
- (void)updateStyleWithData:(NSDictionary *)data {
    if(!data) return;
    if(data[@"direction"]) {
        _direction = _GetDirection(data[@"direction"]);
    }
    if(data[@"flexDirection"]) {
        _flexDirection = _GetFlexDirection(data[@"flexDirection"]);
    }
    if(data[@"justifyContent"]) {
        _justifyContent = _GetJustifyContent(data[@"justifyContent"]);
    }
    //alignItems
    if(data[@"alignItems"]) {
        _alignItems = _GetAlignItems(data[@"alignItems"]);
    }
    //alignSelf
    if(data[@"alignSelf"]) {
        _alignSelf = _GetAlignSelf(data[@"alignSelf"]);
    }
    //position
    if(data[@"position"]) {
        _positionType = _GetPositionType(data[@"position"]);
    }
    //flexWrap
    if(data[@"flexWrap"]) {
        _flexWrap = _GetWrap(data[@"flexWrap"]);
    }
    //overflow
    if(data[@"overflow"]) {
        _overflow = _GetOverflow(data[@"overflow"]);
    }
    //display
    if(data[@"display"]) {
        _display = _GetDisplay(data[@"display"]);
    }
    //flex
    if(data[@"flex"]) {
        _flex = [data[@"flex"] intValue];
    }
    //flexGrow
    if(data[@"flexGrow"]) {
        _flexGrow = [data[@"flexGrow"] intValue];
    }
    //flexShrink
    if(data[@"flexShrink"]) {
        _flexShrink = [data[@"flexShrink"] intValue];
    }
    //top
    if(data[@"top"]) {
        _position.top = [data[@"top"] floatValue];
    }
    //left
    if(data[@"left"]) {
        _position.left = [data[@"left"] floatValue];
    }
    //right
    if(data[@"right"]) {
        _position.right = [data[@"right"] floatValue];
    }
    //bottom
    if(data[@"bottom"]) {
        _position.bottom = [data[@"bottom"] floatValue];
    }
    //border
    if(data[@"border"]) {
        _border = [[DomBorder alloc] initWithBorderContent:data[@"border"]];
    }
    //borderWidth
    if(data[@"borderWidth"]) {
        if(!_border) {
            _border = [[DomBorder alloc] init];
        }
        _border.width = [data[@"borderWidth"] floatValue];
    }
    //borderStyle
    if(data[@"borderStyle"]) {
        if(!_border) {
            _border = [[DomBorder alloc] init];
        }
        _border.style = data[@"borderStyle"];
    }
    //borderColor
    if(data[@"borderColor"]) {
        if(!_border) {
            _border = [[DomBorder alloc] init];
        }
        _border.color = data[@"borderColor"];
    }
    //marginLeft
    if(data[@"marginLeft"]) {
        _margin.left = [data[@"marginLeft"] floatValue];
    }
    //marginRight
    if(data[@"marginRight"]) {
        _margin.right = [data[@"marginRight"] floatValue];
    }
    //marginTop
    if(data[@"marginTop"]) {
        _margin.top = [data[@"marginTop"] floatValue];
    }
    //marginBottom
    if(data[@"marginBottom"]) {
        _margin.bottom = [data[@"marginBottom"] floatValue];
    }
    //paddingLeft
    if(data[@"paddingLeft"]) {
        _padding.left = [data[@"paddingLeft"] floatValue];
    }
    //paddingRight
    if(data[@"paddingRight"]) {
        _padding.right = [data[@"paddingRight"] floatValue];
    }
    //paddingTop
    if(data[@"paddingTop"]) {
        _padding.top = [data[@"paddingTop"] floatValue];
    }
    //paddingBottom
    if(data[@"paddingBottom"]) {
        _padding.bottom = [data[@"paddingBottom"] floatValue];
    }
    //width
    if(data[@"width"]) {
        _width = [data[@"width"] floatValue];
    }
    //height
    if(data[@"height"]) {
        _height = [data[@"height"] floatValue];
    }
    //maxWidth
    if(data[@"maxWidth"]) {
        _maxWidth = [data[@"maxWidth"] floatValue];
    }
    //minWidth
    if(data[@"minWidth"]) {
        _minWidth = [data[@"minWidth"] floatValue];
    }
    //maxHeight
    if(data[@"maxHeight"]) {
        _maxHeight = [data[@"maxHeight"] floatValue];
    }
    //minHeight
    if(data[@"minHeight"]) {
        _minHeight = [data[@"minHeight"] floatValue];
    }
}
- (void)fill:(YGNodeRef)ygNode {
    YGNodeStyleSetDirection(ygNode, _direction);
    YGNodeStyleSetDisplay(ygNode, _display);
    YGNodeStyleSetFlexDirection(ygNode, _flexDirection);
    YGNodeStyleSetJustifyContent(ygNode, _justifyContent);
    YGNodeStyleSetAlignSelf(ygNode, _alignSelf);
    YGNodeStyleSetAlignItems(ygNode, _alignItems);
    YGNodeStyleSetPositionType(ygNode, _positionType);
    YGNodeStyleSetFlexWrap(ygNode, _flexWrap);
    YGNodeStyleSetOverflow(ygNode, _overflow);
    YGNodeStyleSetFlex(ygNode, _flex);
    YGNodeStyleSetFlexGrow(ygNode, _flexGrow);
    YGNodeStyleSetFlexShrink(ygNode, _flexShrink);
    if(_width >= 0) YGNodeStyleSetWidth(ygNode, _width);
    if(_height >= 0) YGNodeStyleSetHeight(ygNode, _height);
    if(_minWidth >= 0) YGNodeStyleSetMinWidth(ygNode, _minWidth);
    if(_minHeight >= 0) YGNodeStyleSetMinHeight(ygNode, _minHeight);
    if(_maxWidth >= 0) YGNodeStyleSetMaxWidth(ygNode, _maxWidth);
    if(_maxHeight >= 0) YGNodeStyleSetMinWidth(ygNode, _maxHeight);
    YGNodeStyleSetBorder(ygNode, YGEdgeAll, _border.width);
    /// Padding
    if(self.padding.left >= 0)     YGNodeStyleSetPadding(ygNode, YGEdgeLeft, self.padding.left);
    if(self.padding.top >= 0)      YGNodeStyleSetPadding(ygNode, YGEdgeTop, self.padding.top);
    if(self.padding.right >= 0)    YGNodeStyleSetPadding(ygNode, YGEdgeRight, self.padding.right);
    if(self.padding.bottom >= 0)   YGNodeStyleSetPadding(ygNode, YGEdgeBottom, self.padding.bottom);
    /// Margin
    if(self.margin.left >= 0)      YGNodeStyleSetMargin(ygNode, YGEdgeLeft, self.margin.left);
    if(self.margin.top >= 0)       YGNodeStyleSetMargin(ygNode, YGEdgeTop, self.margin.top);
    if(self.margin.right >= 0)     YGNodeStyleSetMargin(ygNode, YGEdgeRight, self.margin.right);
    if(self.margin.bottom >= 0)    YGNodeStyleSetMargin(ygNode, YGEdgeBottom, self.margin.bottom);
    /// Position
    if(self.position.left >= 0)    YGNodeStyleSetPosition(ygNode, YGEdgeLeft, self.position.left);
    if(self.position.top >= 0)     YGNodeStyleSetPosition(ygNode, YGEdgeTop, self.position.top);
    if(self.position.right >= 0)   YGNodeStyleSetPosition(ygNode, YGEdgeRight, self.position.right);
    if(self.position.bottom >= 0)  YGNodeStyleSetPosition(ygNode, YGEdgeBottom, self.position.bottom);
    
}
@end
