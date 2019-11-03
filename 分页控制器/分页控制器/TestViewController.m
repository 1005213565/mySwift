//
//  TestViewController.m
//  分页控制器
//
//  Created by mac on 2019/11/1.
//  Copyright © 2019 mac. All rights reserved.
//

#import "TestViewController.h"
#import "SFSlideShadowAnimation.h"
#import "SFPageBaseTableView.h"

@interface TestViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *myTableView;

@end

@implementation TestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.myTableView = [[SFPageBaseTableView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height - 64 - 50)];
    self.myTableView.delegate = self;
    self.myTableView.dataSource = self;
    [self.myTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    [self.view addSubview:self.myTableView];
    
    self.myTableView.scrollEnabled = NO;
    NSLog(@"视图已经加载");
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeScrollEnable:) name:@"changeScrollEnable" object:nil];
    NSLog(@"视图将要出现");
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    NSLog(@"视图将要消失");
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 30;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    cell.textLabel.text = @"年后";
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 70;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    if (scrollView.contentOffset.y <= 0) {
        
        [[NSNotificationCenter defaultCenter] postNotificationName:@"scrollSupportMultipleGesture" object:@{@"supportMultiple":@(YES)}];
    }else {
        
        [[NSNotificationCenter defaultCenter] postNotificationName:@"scrollSupportMultipleGesture" object:@{@"supportMultiple":@(NO)}];
    }
    
}

- (void) changeScrollEnable:(NSNotification *)sender {
    
    NSDictionary *dic = sender.object;
    
        
    self.myTableView.scrollEnabled = [dic[@"scrollEnable"] boolValue];
    
}

@end
