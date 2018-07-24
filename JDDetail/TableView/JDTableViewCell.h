//
//  JDTableViewCell.h
//  JDDetail
//
//  Created by Guangleijia on 2018/7/23.
//  Copyright © 2018年 Reboot. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JDTableViewCell : UIView

@property(nonatomic, strong) NSString *reuseID;

@property(nonatomic, strong) UILabel *textLabel;

- (instancetype)initWithIdentifier:(NSString *)identifier;
@end
