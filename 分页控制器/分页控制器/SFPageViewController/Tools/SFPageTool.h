//
//  SFPageTool.h
//  分页控制器
//
//  Created by fly on 2019/11/2.
//  Copyright © 2019 mac. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface SFPageTool : NSObject

/// 通过颜色获取RGB
+ (NSArray *)getRGBByColor:(UIColor *)originColor;

/**
 originColor需要转换的颜色
 progress：转换颜色比例 小于等于1
 返回 一个转换后的颜色
 
 */
+ (UIColor *) transformColor:(UIColor *)originColor progress:(CGFloat)progress;

/// 是否是iphoneX系列
+ (BOOL)isIphoneX;

/// 导航栏高度
+ (CGFloat) navigationBarHeight;

/// 状态栏高度
+ (CGFloat) statusBarHeight;

/// 屏幕宽度
+ (CGFloat) screenWidth;

/// 屏幕高度
+ (CGFloat) screenHeight;
@end
