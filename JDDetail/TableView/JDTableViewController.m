//
//  JDTableViewController.m
//  JDDetail
//
//  Created by Guangleijia on 2018/7/23.
//  Copyright © 2018年 Reboot. All rights reserved.
//

#import "JDTableViewController.h"
#import "JDTableView.h"
#import "JDTableViewCell.h"
#import "UIView+Extension.h"
@interface JDTableViewController ()<JDTableViewDelegate>{
    JDTableView *_tableView;
}

@end

@implementation JDTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UITableView;
    
    _tableView = [JDTableView new];
    _tableView.jdDelegate = self;
    [self.view addSubview:_tableView];
    
    [_tableView reloadData];
}


- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    
    _tableView.frame = CGRectMake(0, 0, self.view.width, self.view.height);
}


- (CGFloat)tableView:(JDTableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50.0f;
}

- (NSInteger)tableView:(JDTableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 20;
}

- (JDTableViewCell *)tableView:(JDTableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static const NSString *reuseId = @"cellID";
    JDTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseId];
    if (!cell) {
        cell = [[JDTableViewCell alloc] initWithIdentifier:reuseId];
    }
    
    if (indexPath.row % 2) {
        cell.backgroundColor = [UIColor lightGrayColor];
    }else {
        cell.backgroundColor = [UIColor blueColor];
    }
    
    cell.textLabel.text = [NSString stringWithFormat:@"%ld", indexPath.row];
    
    return cell;
}

@end
