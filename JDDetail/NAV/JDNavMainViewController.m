//
//  JDNavMainViewController.m
//  JDDetail
//
//  Created by Guangleijia on 2018/7/25.
//  Copyright © 2018年 Reboot. All rights reserved.
//
/** UINavigationController 原理
 1. nav.navigationBar       - 导航区
 2. nav.viewControllers;    - 内容区
 3. nav.toolbar;            - 工具区
 
 
 
 */
#import "JDNavMainViewController.h"

@interface JDNavMainViewController ()<UITableViewDelegate, UITableViewDataSource>{
    NSArray *_dataArray;
}
@property(nonatomic, strong) UIScrollView *scrollView;
@property(nonatomic, strong) UIView *OnView;
@property(nonatomic, strong) UITableView *tableView;
;

@end

@implementation JDNavMainViewController
+ (void)initialize {
    [super initialize];
    NSLog(@"%s", __FUNCTION__);
}

+ (void)load {
    NSLog(@"%s", __FUNCTION__);
    [super load];
}
- (void)viewDidAppear:(BOOL)animated {
    NSLog(@"before - %s", __FUNCTION__);
    [super viewDidAppear:animated];
    NSLog(@"after - %s", __FUNCTION__);
}
- (void)viewDidDisappear:(BOOL)animated {
    NSLog(@"before - %s", __FUNCTION__);
    [super viewDidDisappear:animated];
    
    NSLog(@"after - %s", __FUNCTION__);
}

- (void)viewDidLoad {
    NSLog(@"%s", __FUNCTION__);
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"nav";
    
    [self.view addSubview:self.tableView];
    
//    UINavigationController *nav;
//    nav.navigationBar.items;
//    nav.viewControllers;
//    nav.toolbar;
//
//    nav.navigationItem;
//
////    [self.view addSubview:self.scrollView];
////    [self.view addSubview:self.OnView];
////
//    [self setTranslucentAndAll];
//    if (@available(iOS 11.0, *)) {
//        self.scrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentAutomatic;
//    } else {
//        // Fallback on earlier versions
//    }
//
//    // 设置返回按钮 图标 ()
//    [self.alphaImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
//    self.navigationController.navigationBar.backIndicatorImage;
//    self.navigationController.navigationBar.backIndicatorTransitionMaskImage;
}

- (UIImage *)alphaImage {
    UIGraphicsBeginImageContext(CGSizeMake(50.f, 50.f));
    
    [[[UIColor whiteColor] colorWithAlphaComponent:0.f] setFill];
    UIRectFill(CGRectMake(0, 0, 100, 100));
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    return image;
}


- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableFooterView = [UIView new];
        _tableView.rowHeight = 60.f;
    }
    return _tableView;
}

- (NSArray *)dataArray {
    if (!_dataArray) {
        _dataArray = @[@{@"title":@"专场动画原理解析", @"destVC":@"JDTransitionUndergroundViewController"},
                       @{@"title":@"系统转场动画 手势替换", @"destVC":@"JDTransitonSystemViewController"},
                       @{@"title":@"转场高级动画", @"destVC":@"JDTransitionSuperViewController"},];
    }
    return _dataArray;
}

#pragma mark - delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    Class VCClass = NSClassFromString([self.dataArray[indexPath.row] valueForKey:@"destVC"]);
    [self.navigationController pushViewController:[VCClass new] animated:YES];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark - datasource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *reuseId = @"navReuseID";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseId];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:reuseId];
    }
    
    cell.textLabel.text = [_dataArray[indexPath.row] valueForKey:@"title"];
    cell.textLabel.font = [UIFont boldSystemFontOfSize:20.f];
    cell.backgroundColor = JDColor(arc4random_uniform(255), arc4random_uniform(255), arc4random_uniform(255));
    return cell;
}

/**
 对 控制器 View 的影响;
 对 scrollView 的影响;
 
 */
- (void)setTranslucentAndAll {
    self.navigationController.navigationBar.translucent = YES;
    self.edgesForExtendedLayout = UIRectEdgeAll;
//    self.extendedLayoutIncludesOpaqueBars = YES;
    self.automaticallyAdjustsScrollViewInsets = YES;
}



#pragma mark - Getter
- (UIView *)OnView {
    if (!_OnView) {
        _OnView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 200, 200)];
        _OnView.backgroundColor = [UIColor redColor];
        
    }
    return _OnView;
}

- (UIScrollView *)scrollView {
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(150, 0, kScreenWidth, kScreenHeight)];
        _scrollView.contentSize = CGSizeMake(kScreenWidth, kScreenHeight*1.5);
        _scrollView.backgroundColor = [UIColor yellowColor];
        
        UIView *onScroll = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
        onScroll.backgroundColor = [UIColor cyanColor];
        [_scrollView addSubview:onScroll];
    }
    
    return _scrollView;
}



@end
