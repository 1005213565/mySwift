//
//  ViewController.m
//  分页控制器
//
//  Created by mac on 2019/10/30.
//  Copyright © 2019 mac. All rights reserved.
//

#import "ViewController.h"
#import "SFPageScrollMenuView.h"
#import "TestViewController.h"
#import "SFPageViewController.h"

@interface ViewController ()<SFPageScrollMenuViewDelegate>

@property (nonatomic, strong) TestViewController *testVC;

@end

#define screenWidth [UIScreen mainScreen].bounds.size.width
#define screenHeight [UIScreen mainScreen].bounds.size.height


@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    SFPageConfig *config = [SFPageConfig new];
    config.itemSelectMaxScale = 1;
    config.isAllItemAverageMenum = YES;
    config.itemLeftMargin = 20;
    config.isTranslationItemCenter = YES;
    config.menuScrollViewBgColor = [UIColor greenColor];
    config.currentIndex = 2;
//    SFPageScrollMenuView *menuView = [SFPageScrollMenuView pagescrollMenuViewWithFrame:CGRectMake(0, 64, screenWidth, 50) titles:@[@"标",@"标题二啊哈",@"标题三",@"标题一开始大幅静安",@"标题二",@"头条",@"标题一",@"推荐",@"标题三"].mutableCopy configration:config delegate:self currentIndex:2];
//    menuView.backgroundColor = [UIColor greenColor];
//    [self.view addSubview:menuView];
    
    SFPageViewController *pageVC = [SFPageViewController pageViewControllerWithControllers:[self getControllers] titles:[self getTitles] config:config];
    pageVC.view.frame = CGRectMake(0, 0, screenWidth, screenHeight);
    [self addChildViewController:pageVC];
    [pageVC didMoveToParentViewController:self];
    [self.view addSubview:pageVC.view];

}

#pragma mark ---SFPageScrollMenuViewDelegate---
/// 点击item
- (void)sfScrollMenuViewItemOnClick:(UIButton *)button index:(NSInteger)index {
    
    NSLog(@"点击了==%zd",index);
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
//    self.testVC.view.frame = CGRectMake(0, 200, screenWidth, 400);
//    [self addChildViewController:self.testVC];
//    [self.testVC didMoveToParentViewController:self];
//    [self.view addSubview:self.testVC.view];
//
//    [self.testVC.view removeFromSuperview];
//    [self.testVC willMoveToParentViewController:nil];
//    [self.testVC removeFromParentViewController];
}

- (TestViewController *)testVC {
    
    if (!_testVC) {
        
        _testVC = [TestViewController new];
    }
    return _testVC;
}

- (NSArray *)getControllers {
    
    TestViewController *oneVC = [TestViewController new];
    oneVC.view.backgroundColor = [UIColor grayColor];
    
    TestViewController *twoVC = [TestViewController new];
    twoVC.view.backgroundColor = [UIColor purpleColor];
    
    TestViewController *thirdVC = [TestViewController new];
    thirdVC.view.backgroundColor = [UIColor yellowColor];
    
    TestViewController *fourVC = [TestViewController new];
    fourVC.view.backgroundColor = [UIColor blueColor];
    
    
    return @[oneVC,twoVC,thirdVC,fourVC];
}

- (NSArray *)getTitles {
    
    return @[@"推荐",@"精选",@"你喜欢的",@"美妆秀"];
}

@end
