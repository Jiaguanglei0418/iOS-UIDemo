//
//  JDSearchViewController.m
//  JDDetail
//
//  Created by Guangleijia on 2018/7/24.
//  Copyright © 2018年 Reboot. All rights reserved.
//

#import "JDSearchViewController.h"
#import "JDDataModel.h"
#import "UIView+Size.h"
#import "JDSearchResultViewController.h"
#import <objc/runtime.h>

@interface JDSearchViewController ()<UITableViewDelegate, UITableViewDataSource, UISearchResultsUpdating, UISearchControllerDelegate> {
    
    NSArray *dataArr;
    NSArray *filterArr;
    
}
@property(nonatomic, strong) UITableView *tableView;
@property(nonatomic, strong) UIScrollView *scrollView;
@property(nonatomic, strong) UISearchController *searchCtrl;
@end

@implementation JDSearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor whiteColor];

    self.definesPresentationContext = YES;
    
    // 设置数据源
    dataArr = [[JDDataModel sharedDataModel] dataArr];
    filterArr = dataArr;
    
    [self.view addSubview:self.tableView];
    
    if (@available(iOS 11, *)) {
        self.navigationItem.searchController = self.searchCtrl;
        self.navigationItem.hidesSearchBarWhenScrolling = NO;
    } else {
        self.tableView.tableHeaderView = self.searchCtrl.searchBar;
    }
    
    [self customSearchbar];
}

- (void)customSearchbar {
 
    // 修改取消按钮的文字, 将 cancel 修改为取消
    // 方法一: 修改私有属性 (可能被拒)
    [self.searchCtrl.searchBar setValue:@"取消" forKeyPath:@"_cancelButtonText"];
    
    // 方法二:
//    [[UIButton appearanceWhenContainedInInstancesOfClasses:@[[UISearchBar class]]] setTitle:@"取消" forState:UIControlStateNormal];
    [[UIBarButtonItem appearanceWhenContainedInInstancesOfClasses:@[[UISearchBar class]]] setTitle:@"取消"];
    
    
    // textField 半圆形
    UITextField *textField = [self.searchCtrl.searchBar valueForKey:@"_searchField"];
    textField.backgroundColor = [UIColor redColor];
    textField.layer.cornerRadius = 15.f;
    textField.layer.borderWidth = 2.0f;
    textField.layer.masksToBounds = YES;
    textField.layer.borderColor = [UIColor greenColor].CGColor;
    textField.placeholder = @"132";
    // 修改光标颜色
    textField.tintColor = [UIColor lightGrayColor];
    
    // 修改 searchbar 背景色白色
    self.searchCtrl.searchBar.barTintColor = [UIColor cyanColor];
    
    // 修改取消文字颜色, 光标颜色(默认光标颜色与取消文字颜色一致, 如果通过 textField 设置 tintColor, 则按照 tintColor 设置为准)
    self.searchCtrl.searchBar.tintColor = [UIColor redColor];
    
    // 去掉上下两条线
//    [self.searchCtrl.searchBar setBackgroundImage:nil];
    
    if (@available(iOS 11, *)) {
        for (UIView *view in textField.subviews) {
            if ([view isKindOfClass:NSClassFromString(@"_UISearchBarSearchFieldBackgroundView")]) {
                [view removeFromSuperview];
            }
        }
        
    }
    
    for (UIView *view in self.searchCtrl.searchBar.subviews.firstObject.subviews) {
        
            if ([view isKindOfClass:NSClassFromString(@"UISearchBarBackground")]) {
                [view removeFromSuperview];
            }
        
    }
    
    // 设置居中显示
    [self.searchCtrl.searchBar setPositionAdjustment:UIOffsetMake(10.f, 0.f) forSearchBarIcon:UISearchBarIconSearch];
}

#pragma mark - UISearchControllerDelegate

- (void)willPresentSearchController:(UISearchController *)searchController {
    
    NSLog(@"%s%@", __FUNCTION__, self.searchCtrl.searchBar.subviews.firstObject.subviews);
}
- (void)didPresentSearchController:(UISearchController *)searchController {
    NSLog(@"%s%@", __FUNCTION__, self.searchCtrl.searchBar.subviews.firstObject.subviews);
    
}


#pragma mark UISearchController searchUpdating delegate method
- (void)updateSearchResultsForSearchController:(UISearchController *)searchController {
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"(SELF CONTAINS %@)", searchController.searchBar.text];
    
    JDSearchResultViewController *resultViewCtroller = (JDSearchResultViewController *)searchController.searchResultsController;
    
    
    filterArr = [dataArr filteredArrayUsingPredicate:predicate];
    filterArr = searchController.searchBar.text.length>0?filterArr:dataArr;
    
    resultViewCtroller.filterDataArr = filterArr;
    
}

#pragma mark - delegate && datasource method
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return filterArr.count;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    
    cell.textLabel.text = filterArr[indexPath.row];
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
//    NSLog(@"%@", class_getInstanceVariable([self.searchCtrl.searchBar class], "UINavigationButton"));
    
}

#pragma mark - getter method
- (UITableView *)tableView {
    
    if (!_tableView) {
        
        CGFloat yCoordinate = 0.f;
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0.f, yCoordinate, self.view.eoc_width, self.view.eoc_height-yCoordinate) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [_tableView setTableFooterView:[[UIView alloc] init]];
        
    }
    
    return _tableView;
}

- (UISearchController *)searchCtrl {
    
    if (!_searchCtrl) {
        
        JDSearchResultViewController *resultSearchCtrl = [[JDSearchResultViewController alloc] init];
        _searchCtrl = [[UISearchController alloc] initWithSearchResultsController:resultSearchCtrl];
        _searchCtrl.dimsBackgroundDuringPresentation = YES;
        _searchCtrl.hidesNavigationBarDuringPresentation = YES;
        _searchCtrl.searchBar.placeholder = @"placeholder";
        _searchCtrl.searchResultsUpdater = self;
        _searchCtrl.delegate = self;
        //        _searchCtrl.searchBar.delegate
        //        _seachCtrl.delegate
        
    }
    
    return _searchCtrl;
    
}

- (UIScrollView *)scrollView {
    
    if (!_scrollView) {
        
        CGFloat yCoordinate = 0.f;
        _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0.f, yCoordinate, self.view.eoc_width, self.view.eoc_height-yCoordinate)];
        
        UIView *redView = [[UIView alloc] initWithFrame:CGRectMake(0.f, 0.f, self.view.eoc_width, self.view.eoc_height)];
        redView.backgroundColor = [UIColor redColor];
        [_scrollView addSubview:redView];
        
    }
    
    return _scrollView;
}

@end
