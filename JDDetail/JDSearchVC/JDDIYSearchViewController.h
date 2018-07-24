//
//  JDDIYSearchViewController.h
//  JDDetail
//
//  Created by Guangleijia on 2018/7/24.
//  Copyright © 2018年 Reboot. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JDDIYSearchBar.h"

@class JDDIYSearchViewController;

@protocol JDDIYSearchViewControllerDelegate
- (void)didPresentSearchController:(JDDIYSearchViewController *)searchController;
- (void)didDismissSearchController:(JDDIYSearchViewController *)searchController;

@end

@protocol JDSearchResultsUpdating
- (void)updateSearchResultForSearchController:(JDDIYSearchViewController *)searchController;
@end


@interface JDDIYSearchViewController : UIViewController

@property(nonatomic, strong)JDDIYSearchBar *searchBar;
@property(nonatomic, weak) id<JDSearchResultsUpdating> searchResultsUpdater;
@property(nonatomic, weak) id<JDDIYSearchViewControllerDelegate> delegate;
@property(nonatomic, strong) UIViewController *searchResultsController;

- (instancetype)initWithSearchResultController:(UIViewController *)searchReasultsController;

@end
