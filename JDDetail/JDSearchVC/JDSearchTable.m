//
//  JDSearchTable.m
//  JDDetail
//
//  Created by Guangleijia on 2018/7/24.
//  Copyright © 2018年 Reboot. All rights reserved.
//

#import "JDSearchTable.h"

@implementation JDSearchTable

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {
    
    if (self = [super initWithFrame:frame style:style]) {
        
        self.delegate = self;
        self.dataSource = self;
        
    }
    
    return self;
}

#pragma mark - UIScrollView delegate method
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    if (_scrollBlock) {
        
        _scrollBlock();
        
    }
    
}

#pragma mark - UITableView delegate&&datasource method
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        
        if (!_searchHistoryArr.count) {
            
            return 250.f;
        }
        
        return 80.f;
        
    } else if (indexPath.section == 1 && indexPath.row > 0) {
        
        return 44.f;
    }
    
    return 35.f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 10.f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.1f;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (!_searchHistoryArr.count) {
        return 1;
    }
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (!section) {
        return 1;
    }
    return _searchHistoryArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    //创建热门搜索记录
    if (indexPath.section == 0) {
        
        if (!_searchHistoryArr.count) {
            [self createHotSearchHistory:cell hasHistory:NO];
        } else {
            [self createHotSearchHistory:cell hasHistory:YES];
        }
        
    } else {
        //创建历史搜索
        if (indexPath.row) {
            cell.textLabel.font = [UIFont systemFontOfSize:15.f];
            cell.textLabel.textColor = [UIColor grayColor];
        }
        cell.textLabel.text = _searchHistoryArr[indexPath.row];
        
    }
    
    return cell;
}

#pragma mark - 创建热门搜索记录
- (void)createHotSearchHistory:(UITableViewCell *)cell hasHistory:(BOOL)hasHistory
{
    //热搜view
    UIView *hotSearchView = [[UIView alloc] init];
    hotSearchView.backgroundColor = [UIColor clearColor];
    [cell addSubview:hotSearchView];
    
    UILabel *hotSearchHistroyLabel = [[UILabel alloc] initWithFrame:CGRectMake(15.f, 0.f, 100.f, 30.f)];
    hotSearchHistroyLabel.text = @"热搜";
    [hotSearchView addSubview:hotSearchHistroyLabel];
    
    //热搜词汇数组
    NSArray *hotSearchWords = @[@"美特斯邦威", @"黄尾袋鼠", @"孕妇袜", @"广角镜头手机", @"唇彩唇蜜", @"汽车坐垫", @"应急启动电源", @"钢笔", @"鼠标垫护腕", @"不粘锅煎锅", @"橄榄调和油", @"铝框拉杆箱"];
    
    //热搜词汇btn
    if (hasHistory) {
        
        UIScrollView *scrollView = [[UIScrollView alloc] init];
        scrollView.showsHorizontalScrollIndicator = NO;
        [hotSearchView addSubview:scrollView];
        
        CGFloat xCoordinate = 15.f;
        for (int i=0; i<hotSearchWords.count; i++) {
            
            NSString *hotWord = hotSearchWords[i];
            CGSize hotWordSize = [hotWord sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12.f]}];
            
            UIButton *hotWordBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            hotWordBtn.frame = CGRectMake(xCoordinate, 10.f, hotWordSize.width+20.f, 30.f);
            hotWordBtn.titleLabel.font = [UIFont systemFontOfSize:12.f];
            [hotWordBtn setTitle:hotWord forState:UIControlStateNormal];
            hotWordBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
            //            [hotWordBtn addTarget:self action:@selector(hotWordAction) forControlEvents:UIControlEventTouchUpInside];
            
            xCoordinate = hotWordBtn.frame.origin.x+hotWordBtn.frame.size.width+10;
            
            hotWordBtn.layer.cornerRadius = 6.f;
            hotWordBtn.layer.masksToBounds = YES;
            hotWordBtn.backgroundColor = [UIColor lightGrayColor];
            [scrollView addSubview:hotWordBtn];
        }
        
        scrollView.frame = CGRectMake(0.f, 30.f, kScreenWidth, 50.f);
        scrollView.contentSize = CGSizeMake(xCoordinate, 50.f);
        hotSearchView.frame = CGRectMake(0.f, 0.f, kScreenWidth, scrollView.frame.origin.y+scrollView.frame.size.height);
        
    } else {
        
        CGFloat xCoordinate = 15.f;
        CGFloat yCoordinate = 40.f;
        for (int i=0; i<hotSearchWords.count; i++) {
            
            NSString *hotWord = hotSearchWords[i];
            CGSize hotWordSize = [hotWord sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12.f]}];
            
            if (xCoordinate+hotWordSize.width+20.f > kScreenWidth) {
                xCoordinate = 15.f;
                yCoordinate += 45.f;
            }
            
            UIButton *hotWordBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            hotWordBtn.frame = CGRectMake(xCoordinate, yCoordinate, hotWordSize.width+20.f, 30.f);
            hotWordBtn.titleLabel.font = [UIFont systemFontOfSize:12.f];
            [hotWordBtn setTitle:hotWord forState:UIControlStateNormal];
            hotWordBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
            //            [hotWordBtn addTarget:self action:@selector(hotWordAction) forControlEvents:UIControlEventTouchUpInside];
            
            xCoordinate = hotWordBtn.frame.origin.x+hotWordBtn.frame.size.width+10;
            
            hotWordBtn.layer.cornerRadius = 6.f;
            hotWordBtn.layer.masksToBounds = YES;
            hotWordBtn.backgroundColor = [UIColor lightGrayColor];
            [hotSearchView addSubview:hotWordBtn];
        }
        
        hotSearchView.frame = CGRectMake(0.f, 0.f, kScreenWidth, yCoordinate+45.f);
        
    }
    
}


@end
