//
//  JDTableView.h
//  JDDetail
//
//  Created by Guangleijia on 2018/7/23.
//  Copyright © 2018年 Reboot. All rights reserved.
//

#import <UIKit/UIKit.h>

@class JDTableView;
@class JDTableViewCell;

@protocol JDTableViewDelegate
@required
- (CGFloat)tableView:(JDTableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath;
- (NSInteger)tableView:(JDTableView *)tableView numberOfRowsInSection:(NSInteger)section;
- (JDTableViewCell *)tableView:(JDTableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;



@end


@interface JDTableView : UIScrollView

@property(nonatomic, assign) id<JDTableViewDelegate> jdDelegate;
- (nullable __kindof JDTableViewCell *)dequeueReusableCellWithIdentifier:(NSString *)identifier ;
- (void)reloadData;
@end
