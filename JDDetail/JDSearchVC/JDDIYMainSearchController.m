//
//  JDDIYMainSearchController
//  JDDetail
//
//  Created by Guangleijia on 2018/7/24.
//  Copyright © 2018年 Reboot. All rights reserved.
//
/**
     搜索主控制器
 
 */
#import "JDDIYMainSearchController.h"
#import "JDDIYButton.h"
#import "JDDIYSearchViewController.h"
#import "JDSearchResultViewController.h"
#import "JDDIYSearchBar.h"
#import "JDSearchTable.h"
#import "JDDataModel.h"

@interface JDDIYMainSearchController() <CAAnimationDelegate, JDDIYSearchViewControllerDelegate, JDSearchResultsUpdating> {
    JDDIYButton *_scanBtn;
    JDDIYButton *_messageBtn;
}

@property(nonatomic, strong) JDDIYSearchViewController *searchController;
@property(nonatomic, strong) JDSearchTable *searchHistoryTable;
@end

@implementation JDDIYMainSearchController
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    
    [self createNavigationView];
    
    [self.view addSubview:self.searchHistoryTable];
    
    // 获取焦点
    [self.searchController.searchBar becomeFirstResponder];
}

//动画的实现
- (void)viewDidAppear:(BOOL)animated {
    
    //左边的动画
    [UIView animateWithDuration:0.2f animations:^{
 
        self.searchController.searchBar.frame = ({
            
            CGRect frame = self.searchController.searchBar.frame;
            frame.origin.x -= 40.f;
            frame.size.width += 40.f;
            frame;
            
        });
        
        _scanBtn.alpha = 0.f;
        
    }];
    
    //右边的动画
    CABasicAnimation *anim = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    anim.duration = 0.2f;
    anim.fromValue = @1;
    anim.toValue = @0;
    anim.fillMode = kCAFillModeForwards;  //动画截止的时候，依然保持动画最后的效果
    anim.removedOnCompletion = NO;
    anim.delegate = self;
    [_messageBtn.layer addAnimation:anim forKey:nil];
    
    [_messageBtn.layer performSelector:@selector(removeAllAnimations) withObject:nil afterDelay:1];
    
}

#pragma mark - CAAnimation delegate
- (void)animationDidStop:(CABasicAnimation *)anim finished:(BOOL)flag {
    
    //anim（深拷贝,内容复制，地址不一样） 它跟  上面的anim  不是一个anim
    if ([anim.keyPath isEqualToString:@"transform.scale"]) {
        
        //改变button
        _messageBtn.noImage = YES;
        [_messageBtn setTitle:@"取消" forState:UIControlStateNormal];
        
        //继续另外一个动画
        CABasicAnimation *anim1 = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
        anim1.duration = 0.2f;
        anim1.fromValue = @0;
        anim1.toValue = @1;
        anim1.fillMode = kCAFillModeForwards;
        anim1.removedOnCompletion = NO;
        [_messageBtn.layer addAnimation:anim1 forKey:nil];
        
    }
    
}


#pragma mark - EOCSearchResultsUpdating 以及 EOCSearchControllerDelegate 的实现
- (void)updateSearchResultForSearchController:(JDDIYSearchViewController *)searchController{
    
    NSString *searchText = searchController.searchBar.text;
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"(SELF CONTAINS %@)", searchText];
    
    JDSearchResultViewController *resultViewCtrl = (JDSearchResultViewController *)searchController.searchResultsController;
    NSArray *dataArr = [JDDataModel sharedDataModel].dataArr;
    resultViewCtrl.filterDataArr = [dataArr filteredArrayUsingPredicate:predicate];
    
}

- (void)didPresentSearchController:(JDDIYSearchViewController *)searchController {
    
    [self addChildViewController:self.searchController];
    [self.view addSubview:self.searchController.view];
    
}

- (void)didDismissSearchController:(JDDIYSearchViewController *)searchController {
    
    [self.searchController.view removeFromSuperview];
    [self.searchController removeFromParentViewController];
    
}


#pragma mark - event response
- (void)scanAction {
    
    
}

- (void)messageAction {
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"searchBarRemove" object:nil];
    [self removeFromParentViewController];
    [self.view removeFromSuperview];
    
}

#pragma mark - create navView
- (void)createNavigationView {
    
    UIView *navView = [[UIView alloc] initWithFrame:CGRectMake(0.f, kStatusBarHeight, self.view.width, 44.f)];
    [self.view addSubview:navView];
    
    //创建扫描按钮
    _scanBtn = [JDDIYButton buttonWithType:UIButtonTypeCustom];
    _scanBtn.frame = CGRectMake(10.f, 7.f, 30.f, 33.f);
    [_scanBtn setTitle:@"扫一扫" forState:UIControlStateNormal];
    [_scanBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [_scanBtn setImage:[UIImage imageNamed:@"scan_gray"] forState:UIControlStateNormal];
    [_scanBtn addTarget:self action:@selector(scanAction) forControlEvents:UIControlEventTouchUpInside];
    [navView addSubview:_scanBtn];
    
    //创建消息按钮
    _messageBtn = [JDDIYButton buttonWithType:UIButtonTypeCustom];
    _messageBtn.frame = CGRectMake(kScreenWidth-40.f, 7.f, 30.f, 33.f);
    [_messageBtn setImage:[UIImage imageNamed:@"message_gray"] forState:UIControlStateNormal];
    [_messageBtn setTitle:@"消息" forState:UIControlStateNormal];
    [_messageBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [_messageBtn addTarget:self action:@selector(messageAction) forControlEvents:UIControlEventTouchUpInside];
    [navView addSubview:_messageBtn];
    
    //创建UISearchBar
    self.searchController.searchBar.frame = CGRectMake(50.f, 8.f, [[UIScreen mainScreen] bounds].size.width-103.f, 28.f);
    [navView addSubview:self.searchController.searchBar];
    
}

#pragma mark - getter method
- (JDDIYSearchViewController *)searchController {
    
    if (!_searchController) {
        
        //搜索结果的viewController
        JDSearchResultViewController *resultViewCtrl = [[JDSearchResultViewController alloc] init];
        _searchController = [[JDDIYSearchViewController alloc] initWithSearchResultController:resultViewCtrl];
        _searchController.searchResultsUpdater = self;
        _searchController.delegate = self;
        
    }
    return _searchController;
}

- (JDSearchTable *)searchHistoryTable {
    
    if (!_searchHistoryTable) {
        
        
        
        //创建搜索记录tableView
        _searchHistoryTable = [[JDSearchTable alloc] initWithFrame:CGRectMake(0.f, kNavigationBarHeight, kScreenWidth, kScreenHeight-kNavigationBarHeight) style:UITableViewStyleGrouped];
        
        if (@available(iOS 11, *)) {
            _searchHistoryTable.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }
        
        __weak typeof(_searchController)weakSearch = _searchController;
        _searchHistoryTable.scrollBlock = ^{
            
            [weakSearch.searchBar resignFirstResponder];
            
        };
        
        //初始化历史搜索记录数组
        _searchHistoryTable.searchHistoryArr = @[@"历史记录", @"八点钟学院", @"笔记本", @"iPhone7", @"化妆品", @"台式机"];
        [self.view addSubview:_searchHistoryTable];
        
        
    }
    
    return _searchHistoryTable;
    
}

- (void)dealloc {
    
    NSLog(@"%s", __func__);
    
}
@end
