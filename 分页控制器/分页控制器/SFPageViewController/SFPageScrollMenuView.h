//
//  SFPageScrollMenuView.h
//  分页控制器
//
//  Created by mac on 2019/10/30.
//  Copyright © 2019 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SFPageConfig.h"

NS_ASSUME_NONNULL_BEGIN

@protocol SFPageScrollMenuViewDelegate <NSObject>

@optional
/// 点击item
- (void)sfScrollMenuViewItemOnClick:(UIButton *)button index:(NSInteger)index;

@end


@interface SFPageScrollMenuView : UIView




/**
 初始化YNPageScrollMenuView
 
 @param frame 大小
 @param titles 标题
 @param configration 配置信息
 @param delegate 代理
 @param currentIndex 当前选中下标
 */
+ (instancetype)pagescrollMenuViewWithFrame:(CGRect)frame
                                     titles:(NSMutableArray *)titles
                               configration:(SFPageConfig *)configration
                                   delegate:(id<SFPageScrollMenuViewDelegate>)delegate
                               currentIndex:(NSInteger)currentIndex;

/// 选中下标
- (void)selectedItemIndex:(NSInteger)index
                 animated:(BOOL)animated;

@end

NS_ASSUME_NONNULL_END
