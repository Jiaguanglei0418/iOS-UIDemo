//
//  JDDIYSearchViewController.m
//  JDDetail
//
//  Created by Guangleijia on 2018/7/24.
//  Copyright © 2018年 Reboot. All rights reserved.
//
/** JDDIYSearchViewController
 
    搜索控制器
 */
#import "JDDIYSearchViewController.h"

@interface JDDIYSearchViewController ()

@end

@implementation JDDIYSearchViewController

- (instancetype)initWithSearchResultController:(UIViewController *)searchReasultsController {
    self = [super init];
    if (searchReasultsController) {
        // 赋值
        self.searchResultsController = searchReasultsController;
       
        self.view.frame = CGRectMake(0.f, kNavigationBarHeight, self.view.width, self.view.height - kNavigationBarHeight);
        
        // 添加搜索结果
        [self addChildViewController:searchReasultsController];
        self.searchResultsController.view.frame = self.view.bounds;
        [self.view addSubview:searchReasultsController.view];
    }
    
    return self;
}


#pragma mark - actionMethod
- (void)textChanged {
    
    // 需要让自己添加到父控制器中, 当前有文字的时候
    if(_delegate && self.searchBar.text.length > 0) {
        [_delegate didPresentSearchController:self];
    }
    
    // dismiss
    if(_delegate && self.searchBar.text.length == 0) {
        [_delegate didDismissSearchController:self];
    }
    
    // 更新 搜索结果
    if(_searchResultsUpdater){
        [_searchResultsUpdater updateSearchResultForSearchController:self];
    }
}

#pragma mark - Getter
- (JDDIYSearchBar *)searchBar {
    if (!_searchBar) {
        _searchBar = [[JDDIYSearchBar alloc] init];
        [_searchBar addTarget:self action:@selector(textChanged) forControlEvents:UIControlEventEditingChanged];
//        _searchBar.delegate = self;
    }
    return _searchBar;
}

- (void)viewDidLoad {
    [super viewDidLoad];


}
@end
