//
//  SFPageViewController.m
//  分页控制器
//
//  Created by mac on 2019/11/1.
//  Copyright © 2019 mac. All rights reserved.
//

#import "SFPageViewController.h"
#import "SFPageScrollMenuView.h"
#import "SFPageBaseScrollView.h"
#import "UIView+SFFrame.h"
#import "UIScrollView+SFExtend.h"
#import "SFPageBaseHederView.h"

@interface SFPageViewController ()<SFPageScrollMenuViewDelegate,UIScrollViewDelegate>

/// 子视图数组
@property (nonatomic, strong) NSMutableArray *childVCMArr;

/// 标题数组
@property (nonatomic, strong) NSMutableArray *titles;

/// 配置信息
@property (nonatomic, strong) SFPageConfig *pageConfig;

/// 菜单栏
@property (nonatomic, strong) SFPageScrollMenuView *menuView;

///
@property (nonatomic, strong) SFPageBaseScrollView *pageScrollView;

///
@property (nonatomic, strong) SFPageBaseScrollView *bgScrollView;

/// 上一个page的位置
@property (nonatomic, assign) NSInteger lastIndex;

/// 当前将要滑动到的位置或者已经滑到到的位置
@property (nonatomic, assign) NSInteger currentIndex;

/// 头部视图的背景视图
@property (nonatomic, strong) SFPageBaseHederView *bgHeaderView;
@end

@implementation SFPageViewController

#pragma mark ---视图生命周期---
- (void)viewDidLoad {
    [super viewDidLoad];
    [self initData];
    [self setupSubViews];
    [self setSelectedPageIndex:self.pageConfig.currentIndex];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
}

#pragma mark ---初始化---
/**
 初始化方法
 @param controllers 子控制器
 @param titles 标题
 @param config 配置信息
 */
+ (instancetype)pageViewControllerWithControllers:(NSArray *)controllers
                                           titles:(NSArray *)titles
                                           config:(SFPageConfig *)config {
    
    SFPageViewController *pageVC = [[SFPageViewController alloc] init];
    pageVC.childVCMArr = controllers.mutableCopy;
    pageVC.titles = titles.mutableCopy;
    pageVC.pageConfig = config;
    
    return pageVC;
}

#pragma mark ---私有方法---
/// 设置子视图
- (void) setupSubViews {
    
    [self setupHeaderView];
    [self setupMenuView];
    [self setupPageScrollView];
}

/// 设置header
- (void) setupHeaderView {
    
    if (self.pageConfig.menuPositionStyle == sfMenuSuspenStyle) {
        
        NSAssert(self.headerView, @"头部视图不存在");
        
        self.bgHeaderView = [[SFPageBaseHederView alloc] initWithFrame:self.headerView.bounds];
        [self.bgHeaderView addSubview:self.headerView];
        
        [self.bgScrollView addSubview:self.bgHeaderView];
    }
}

/// 设置菜单栏
- (void) setupMenuView {
    
    CGFloat menuViewY = 0;
    if (self.pageConfig.menuPositionStyle == sfMenuSuspenStyle) {
        
        menuViewY = self.bgHeaderView.sf_bottom;
    }else if (self.pageConfig.menuPositionStyle == sfMenuTopStyle) {
        
        menuViewY = 0;
    }
    
    SFPageScrollMenuView *menuView = [SFPageScrollMenuView pagescrollMenuViewWithFrame:CGRectMake(0, menuViewY, self.pageConfig.menuWidth, self.pageConfig.menuHeight) titles:self.titles configration:self.pageConfig delegate:self currentIndex:self.pageConfig.currentIndex];
    self.menuView = menuView;
    
    if (self.pageConfig.menuPositionStyle == sfMenuSuspenStyle) {
        
        [self.bgScrollView addSubview:self.menuView];
    }else if (self.pageConfig.menuPositionStyle == sfMenuTopStyle) {
        
        [self.view addSubview:self.menuView];
    }
    
}

/// 设置pageScrollView
- (void) setupPageScrollView {
    
    
    
    self.pageScrollView.frame = CGRectMake(0, self.menuView.sf_bottom, self.pageConfig.pageScrollViewWidth, self.pageConfig.pageScrollViewHeight);
    self.pageScrollView.contentSize = CGSizeMake(self.pageConfig.pageScrollViewWidth * self.titles.count, self.pageConfig.pageScrollViewHeight);
    
    if (self.pageConfig.menuPositionStyle == sfMenuSuspenStyle) {
        
        [self.bgScrollView addSubview:self.pageScrollView];
        
        self.bgScrollView.frame = CGRectMake(0, 0, self.pageConfig.bgScrollViewWidth, self.pageConfig.bgScrollViewHeight);
        self.bgScrollView.contentSize = CGSizeMake(self.pageConfig.bgScrollViewWidth, self.pageScrollView.sf_bottom);
        [self.view addSubview:self.bgScrollView];
    }else if (self.pageConfig.menuPositionStyle == sfMenuTopStyle) {
        
        [self.view addSubview:self.pageScrollView];;
    }
    
}

/// 初始化数据
- (void)initData {
    [self checkParams];
    
//    self.edgesForExtendedLayout = UIRectEdgeNone;
//    self.view.backgroundColor = [UIColor whiteColor];
    self.automaticallyAdjustsScrollViewInsets = NO;
    
}

///检查数据
- (void) checkParams {
    
    NSAssert(self.titles || self.titles.count != 0, @"标题数量为0");
    NSAssert(self.childVCMArr || self.childVCMArr.count != 0, @"控制器数量为0");
    NSAssert(self.titles.count == self.childVCMArr.count, @"标题数量和控制器数量不匹配");
}

/// 添加子控制器
- (void) addChildViewController:(UIViewController *)childController offsetX:(CGFloat)offsetX {
    
    childController.view.frame = CGRectMake(offsetX, 0, self.pageScrollView.sf_width, self.pageScrollView.sf_height);
    [self addChildViewController:childController];
    [childController didMoveToParentViewController:self];
    [self.pageScrollView addSubview:childController.view];
}

/// 移除子控制器
- (void) removeSFChildViewController:(UIViewController *)childController  {

    [childController.view removeFromSuperview];
    [childController removeFromParentViewController];
    [childController willMoveToParentViewController:nil];
}

#pragma mark ---外部方法---
/// 设置选中的pageView
- (void)setSelectedPageIndex:(NSInteger)pageIndex {
    
    /// scrollView平移位置
    CGFloat offset_X = pageIndex*self.pageConfig.pageScrollViewWidth;
    self.pageScrollView.contentOffset = CGPointMake(offset_X, 0);
    
    
    /// 添加视图控制器
    UIViewController *currentVC = self.childVCMArr[pageIndex];
    [self addChildViewController:currentVC offsetX:offset_X];
    
    // 移除上一个视图控制器
    if (self.currentIndex != self.lastIndex) {
        
        UIViewController *lastVC = self.childVCMArr[self.lastIndex];
        [self removeSFChildViewController:lastVC];
    }
}


#pragma mark ---SFPageScrollMenuViewDelegate---
- (void)sfScrollMenuViewItemOnClick:(UIButton *)button index:(NSInteger)index {
    
    [self setSelectedPageIndex:index];
}

#pragma mark ---UIScrollViewDelegate---

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    

    if (scrollView == self.pageScrollView) {
        
        if (self.pageScrollView.beginOffsetX > scrollView.contentOffset.x) {
            
            self.pageScrollView.isScrollRightDirection = YES;
            //        NSLog(@"向右滚动");
        }else {
            
            self.pageScrollView.isScrollRightDirection = NO;
            //        NSLog(@"向左滚动");
        }
        
        CGFloat indexD = 1.0*scrollView.contentOffset.x/self.pageConfig.pageScrollViewWidth;
        NSInteger currentIndex = 0;
        CGFloat progress = 0.0;
        NSInteger lastIndex = 0;
        // 向右滑动需要向下取整
        if (self.pageScrollView.isScrollRightDirection) {
            
            currentIndex = floor(indexD);
            if (currentIndex < 0) {
                
                currentIndex = 0;
                progress = 0;
                lastIndex = 0;
            }else {
                
                progress = currentIndex + 1 - indexD;
                if (currentIndex == self.childVCMArr.count - 1) {
                    
                    lastIndex = currentIndex;
                }else {
                    
                    lastIndex = currentIndex + 1;
                }
                
            }
            
            
        }else {
            
            // 向左滑动需要向上取整
            currentIndex = ceilf(indexD);
            if (currentIndex > self.childVCMArr.count - 1) {
                
                currentIndex = self.childVCMArr.count - 1;
                progress = 0;
                lastIndex = currentIndex;
            }else {
                
                progress = 1 - (currentIndex - indexD);
                if (currentIndex == 0) {
                    
                    lastIndex = 0;
                }else {
                    
                    lastIndex = currentIndex - 1;
                }
                
            }
        }
        
        //    NSLog(@"当前的位置===%zd,真实数据===%f, 上一个位置===%zd",currentIndex,indexD,lastIndex);
        
        // 菜单栏的item和lineView 实时移动
        [self.menuView willSelectItemIndex:currentIndex lastItemIndex:lastIndex progress:progress];
        
        
        /// 添加视图控制器
        //    [self setSelectedPageIndex:currentIndex];
        /// 添加视图控制器
        CGFloat offset_X = currentIndex*self.pageConfig.pageScrollViewWidth;
        UIViewController *currentVC = self.childVCMArr[currentIndex];
        [self addChildViewController:currentVC offsetX:offset_X];
        
        
        self.currentIndex = currentIndex;
        self.lastIndex = lastIndex;
        /// 滚动结束的记录位置
        self.pageScrollView.beginOffsetX = scrollView.contentOffset.x;
    }else if (scrollView == self.bgScrollView) {
        
        
        if (scrollView.contentOffset.y >= self.bgHeaderView.sf_height) {
            
            [[NSNotificationCenter defaultCenter] postNotificationName:@"changeScrollEnable" object:@{@"scrollEnable":@(YES)}];
        }else {
            
            [[NSNotificationCenter defaultCenter] postNotificationName:@"changeScrollEnable" object:@{@"scrollEnable":@(NO)}];
        }
    }
    
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView  {
    

    if (scrollView == self.pageScrollView) {
        
        // 移除上一个子视图
        if (self.currentIndex != self.lastIndex) { // 如果位置是第一个或最后一个向边界滑动就不移除
            
            UIViewController *lastVC = self.childVCMArr[self.lastIndex];
            [self removeSFChildViewController:lastVC];
        }
    }else if (scrollView == self.bgScrollView) {
        
        
    }
}

#pragma mark ---set方法---
- (void)setHeaderView:(UIView *)headerView {
    _headerView = headerView;
}

#pragma mark ---懒加载---
- (NSMutableArray *)childVCMArr {
    
    if (!_childVCMArr) {
        
        _childVCMArr = [NSMutableArray new];
    }
    return _childVCMArr;
}

- (NSMutableArray *)titles {
    
    if (!_titles) {
        
        _titles = [NSMutableArray new];
    }
    return _titles;
}

- (SFPageConfig *)pageConfig {
    
    if (!_pageConfig) {
        
        _pageConfig = [[SFPageConfig alloc] init];
    }
    return _pageConfig;
}

- (SFPageBaseScrollView *)pageScrollView {
    
    if (!_pageScrollView) {
        _pageScrollView = [[SFPageBaseScrollView alloc] init];
        _pageScrollView.pagingEnabled = YES;
        _pageScrollView.delegate = self;
    }
    return _pageScrollView;
}

- (SFPageBaseScrollView *)bgScrollView {
    
    if (!_bgScrollView) {
        
        _bgScrollView = [[SFPageBaseScrollView alloc] init];
        _bgScrollView.delegate = self;
        _bgScrollView.bounces = NO;
    }
    return _bgScrollView;
}

@end
