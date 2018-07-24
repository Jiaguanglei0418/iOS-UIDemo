//
//  JDSearchResultViewController.m
//  JDDetail
//
//  Created by Guangleijia on 2018/7/24.
//  Copyright © 2018年 Reboot. All rights reserved.
//

#import "JDSearchResultViewController.h"

@interface JDSearchResultViewController ()

@end

@implementation JDSearchResultViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.tableFooterView = [UIView new];
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
 
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
 
    return _filterDataArr.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    if (!cell) {
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        
    }
    
    cell.textLabel.text = _filterDataArr[indexPath.row];
    return cell;
}


- (void)setFilterDataArr:(NSArray *)filterDataArr {
    _filterDataArr = filterDataArr;
    
    [self.tableView reloadData];
}

@end
