//
//  JDSearchTable.h
//  JDDetail
//
//  Created by Guangleijia on 2018/7/24.
//  Copyright © 2018年 Reboot. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^scrollActionBlock)(void);

@interface JDSearchTable : UITableView <UITableViewDelegate, UITableViewDataSource>

@property(nonatomic, strong)NSArray *searchHistoryArr;
@property(nonatomic, strong)scrollActionBlock scrollBlock;

@end
