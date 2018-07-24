//
//  JDCollectionHeaderView.m
//  JDDetail
//
//  Created by Guangleijia on 2018/7/23.
//  Copyright © 2018年 Reboot. All rights reserved.
//

#import "JDCollectionHeaderView.h"
#define kScreenWidth [UIScreen mainScreen].bounds.size.width
#define kScreenHeight [UIScreen mainScreen].bounds.size.height;

@implementation JDCollectionHeaderView{
    NSMutableArray *_labelArray;
}
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        NSArray *weakArray = @[ @" 星期日 ", @" 星期一 ", @" 星期二 ", @" 星期三 ", @" 星期四 ", @" 星期五 ", @" 星期六 "];
        _labelArray = [NSMutableArray arrayWithCapacity:weakArray.count];
        for (NSInteger i = 0; i < weakArray.count; i++) {
            UILabel *label = [[UILabel alloc] init];
            [self addSubview:label];
            label.textAlignment = NSTextAlignmentCenter;
           
            
            label.text = weakArray[i];
            [_labelArray addObject:label];
        }
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    CGFloat labelWidth = kScreenWidth/7;
    CGFloat labelheight = 44.f;
    
    [_labelArray enumerateObjectsUsingBlock:^(UILabel *label, NSUInteger idx, BOOL * _Nonnull stop) {
        label.minimumScaleFactor = 0.1;
        label.adjustsFontSizeToFitWidth = YES;

        label.frame = CGRectMake(idx*labelWidth, 0, labelWidth, labelheight);
    }];
}

@end
