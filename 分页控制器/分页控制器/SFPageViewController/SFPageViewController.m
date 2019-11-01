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

@end

@implementation SFPageViewController

#pragma mark ---视图生命周期---
- (void)viewDidLoad {
    [super viewDidLoad];
    [self initData];
    [self setupSubViews];
    [self setSelectedPageIndex:self.pageConfig.currentIndex];
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
    
    [self setupMenuView];
    [self setupPageScrollView];
}

/// 设置菜单栏
- (void) setupMenuView {
    
    SFPageScrollMenuView *menuView = [SFPageScrollMenuView pagescrollMenuViewWithFrame:CGRectMake(0, 0, self.pageConfig.menuWidth, self.pageConfig.menuHeight) titles:self.titles configration:self.pageConfig delegate:self currentIndex:self.pageConfig.currentIndex];
    self.menuView = menuView;
    [self.view addSubview:self.menuView];
}

/// 设置pageScrollView
- (void) setupPageScrollView {
    
    self.pageScrollView.frame = CGRectMake(0, self.menuView.sf_bottom, self.pageConfig.pageScrollViewWidth, self.pageConfig.pageScrollViewHeight);
    self.pageScrollView.contentSize = CGSizeMake(self.pageConfig.pageScrollViewWidth * self.titles.count, self.pageConfig.pageScrollViewHeight);
    [self.view addSubview:self.pageScrollView];
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

#pragma mark ---外部方法---
/// 设置选中的pageView
- (void)setSelectedPageIndex:(NSInteger)pageIndex {
//    if (self.cacheDictM.count > 0 && pageIndex == self.pageIndex) return;
//
//    if (pageIndex > self.controllersM.count - 1) return;
//
//    CGRect frame = CGRectMake(self.pageScrollView.yn_width * pageIndex, 0, self.pageScrollView.yn_width, self.pageScrollView.yn_height);
//    if (frame.origin.x == self.pageScrollView.contentOffset.x) {
//        [self scrollViewDidScroll:self.pageScrollView];
//    } else {
//        [self.pageScrollView scrollRectToVisible:frame animated:NO];
//    }
//
//    [self scrollViewDidEndDecelerating:self.pageScrollView];
    
    /// scrollView平移位置
    CGFloat offset_X = pageIndex*self.pageConfig.pageScrollViewWidth;
    self.pageScrollView.contentOffset = CGPointMake(offset_X, 0);
    
    
    /// 添加视图控制器
    UIViewController *currentVC = self.childVCMArr[pageIndex];
    [self addChildViewController:currentVC offsetX:offset_X];
}


#pragma mark ---SFPageScrollMenuViewDelegate---
- (void)sfScrollMenuViewItemOnClick:(UIButton *)button index:(NSInteger)index {
    
    [self setSelectedPageIndex:index];
}

#pragma mark ---UIScrollViewDelegate---
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    CGFloat indexD = 1.0*scrollView.contentOffset.x/self.pageConfig.pageScrollViewWidth;
    NSInteger currentIndex = 0;
    // 向右滑动需要向下取整
    if (self.pageScrollView.isScrollRightDirection) {
        
        currentIndex = floor(indexD);
    }else {
        
        // 向左滑动需要向上取整
        currentIndex = ceilf(indexD);
    }
    
    NSLog(@"当前的位置===%zd,真实数据===%f",currentIndex,indexD);
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView;      {
    
    NSInteger currentIndex = round(1.0*scrollView.contentOffset.x/self.pageConfig.pageScrollViewWidth);
    
    // 菜单栏改变
    [self.menuView selectedItemIndex:currentIndex animated:YES];
    
    
    /// 添加视图控制器
    [self setSelectedPageIndex:currentIndex];

}

// called on start of dragging (may require some time and or distance to move)
//- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView;
//
//// called on finger up if the user dragged. velocity is in points/millisecond. targetContentOffset may be changed to adjust where the scroll view comes to rest
//- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset NS_AVAILABLE_IOS(5_0);
//
//
//// called on finger up if the user dragged. decelerate is true if it will continue moving afterwards
//- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate;
//
//- (void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView;   // called on finger up as we are moving
//
//
//- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView; // called when setContentOffset/scrollRectVisible:animated: finishes. not called if not animating
//
//
//- (BOOL)scrollViewShouldScrollToTop:(UIScrollView *)scrollView;   // return a yes if you want to scroll to the top. if not defined, assumes YES
//
//- (void)scrollViewDidScrollToTop:(UIScrollView *)scrollView;      // called when scrolling animation finished. may be called immediately if already at top



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

@end
