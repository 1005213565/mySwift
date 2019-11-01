//
//  SFPageConfig.h
//  分页控制器
//
//  Created by mac on 2019/10/30.
//  Copyright © 2019 mac. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SFPageConfig : NSObject

/// 选择的item位置  默认0
@property (nonatomic, assign) NSInteger currentIndex;

#pragma mark ---menuView----
/// 菜单栏高度  默认50
@property (nonatomic, assign) CGFloat menuHeight;

/// 菜单栏宽度  默认屏幕宽
@property (nonatomic, assign) CGFloat menuWidth;


#pragma mark ---scrollviewMenum---
/// 菜单栏 scrollview背景颜色 默认 white
@property (nonatomic, strong) UIColor *menuScrollViewBgColor;


#pragma mark ---item---

/// 当scrollView菜单的contentSize大于当前菜单的宽度且item可以平移过去，设置为YES则item平移到中间 默认NO
@property (nonatomic, assign) BOOL isTranslationItemCenter;

/// 所有的item是否平分 整个菜单栏默认 NO ，如果为YES则itemLeftMargin，itemFirstAndEndMargin失效
@property (nonatomic, assign) BOOL isAllItemAverageMenum;

/// 当isAllItemAverageMenum是YES的时候，一个item扩展的宽度 默认15
@property (nonatomic, assign) CGFloat itemExtendWidth;

/// item最大的缩放因子 默认1
@property (nonatomic, assign) CGFloat itemSelectMaxScale;

/// item按钮标题选中字体颜色 UIControlStateNormal  默认 red
@property (nonatomic, strong) UIColor *itemTitleSelectColorNormal;

/// item按钮标题正常字体大小 UIControlStateNormal  默认13
@property (nonatomic, assign) CGFloat itemTitleFontNormal;

/// item按钮标题正常字体颜色 UIControlStateNormal  默认 black
@property (nonatomic, strong) UIColor *itemTitleColorNormal;

/// item距离左边按钮距离(除却第一个按钮) 默认 15
@property (nonatomic, assign) CGFloat itemLeftMargin;

/// item第一个和最后一个按钮距离两边的距离 默认 15
@property (nonatomic, assign) CGFloat itemFirstAndEndMargin;



#pragma mark ---底部线条---
/// 是否展示底部线条 默认YES
@property (nonatomic, assign) BOOL isShowBottomLine;

/// 底部线条高度  默认1
@property (nonatomic, assign) CGFloat bottomLineHeight;

/// 底部线条颜色 默认 red
@property (nonatomic, strong) UIColor *bottomLineBgColor;


#pragma mark ---pageScrollView---
/// 滚动视图高  默认是 屏幕高度 - 50
@property (nonatomic, assign) CGFloat pageScrollViewHeight;

/// 滚动视图宽  默认是屏幕宽
@property (nonatomic, assign) CGFloat pageScrollViewWidth;

@end

NS_ASSUME_NONNULL_END
