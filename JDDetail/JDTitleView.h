//
//  JDTitleView.h
//  JDDetail
//
//  Created by Guangleijia on 2018/7/19.
//  Copyright © 2018年 Reboot. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^btnBlock) (int index);

@interface JDTitleView : UIScrollView

@property(nonatomic, strong)NSArray *titleArr;
@property(nonatomic, strong)btnBlock btnActionBlock;
@property(nonatomic, strong)UILabel *indicatorLabel;

@end
