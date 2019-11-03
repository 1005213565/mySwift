//
//  SFPageTool.m
//  分页控制器
//
//  Created by fly on 2019/11/2.
//  Copyright © 2019 mac. All rights reserved.
//

#import "SFPageTool.h"


@implementation SFPageTool

/// 通过颜色获取RGB
+ (NSArray *) getRGBByColor:(UIColor *)originColor {
    
    CGFloat r=0,g=0,b=0,a=0;
    
    const CGFloat *components = CGColorGetComponents(originColor.CGColor);
    r = components[0];
    g = components[1];
    b = components[2];
    a = components[3];
    
    return @[@(r),@(g),@(b)];
}

/**
 originColor需要转换的颜色
 progress：转换颜色比例 小于等于1
 返回 一个转换后的颜色
 
 */
+ (UIColor *) transformColor:(UIColor *)originColor progress:(CGFloat)progress {
    
    NSArray *originColorRGB = [self getRGBByColor:originColor];
    CGFloat r = [originColorRGB[0] floatValue];
    CGFloat g = [originColorRGB[1] floatValue];
    CGFloat b = [originColorRGB[2] floatValue];
    
    UIColor *endColor = [UIColor colorWithRed:r*progress green:g*progress blue:b*progress alpha:1];
    
    return endColor;
}

/// 是否是iphoneX系列
+ (BOOL)isIphoneX {
    
    BOOL isPhoneX = NO;
    if (@available(iOS 11.0, *)) {
        isPhoneX = [[UIApplication sharedApplication] delegate].window.safeAreaInsets.bottom > 0.0?YES:NO;
    }
    return isPhoneX;
    
}

/// 导航栏高度
+ (CGFloat) navigationBarHeight {
   
    if ([SFPageTool isIphoneX]) {
        
        return 88;
    }else {
        
        return 64;
    }
}

/// 状态栏高度
+ (CGFloat) statusBarHeight {
    
    return [[UIApplication sharedApplication] statusBarFrame].size.height;
}

/// 屏幕宽度
+ (CGFloat) screenWidth {
    
    return [UIScreen mainScreen].bounds.size.width;
}

/// 屏幕高度
+ (CGFloat) screenHeight {
    
    return [UIScreen mainScreen].bounds.size.height;
}

@end













