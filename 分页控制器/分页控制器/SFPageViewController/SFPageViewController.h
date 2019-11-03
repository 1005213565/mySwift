//
//  SFPageViewController.h
//  分页控制器
//
//  Created by mac on 2019/11/1.
//  Copyright © 2019 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SFPageConfig.h"

NS_ASSUME_NONNULL_BEGIN

@interface SFPageViewController : UIViewController

/// 头部headerView
@property (nonatomic, strong) UIView *headerView;

/**
 初始化方法
 @param controllers 子控制器
 @param titles 标题
 @param config 配置信息
 */
+ (instancetype)pageViewControllerWithControllers:(NSArray *)controllers
                                           titles:(NSArray *)titles
                                           config:(SFPageConfig *)config;

/// 设置选中的pageView
- (void)setSelectedPageIndex:(NSInteger)pageIndex;
@end

NS_ASSUME_NONNULL_END
