
//
//  JDCollectionViewCell.m
//  JDDetail
//
//  Created by Guangleijia on 2018/7/23.
//  Copyright © 2018年 Reboot. All rights reserved.
//

#import "JDCollectionViewCell.h"

@implementation JDCollectionViewCell
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        _textLabel = [UILabel new];
        _textLabel.textAlignment = NSTextAlignmentCenter;
         
        self.contentView.backgroundColor = [UIColor greenColor];
        [self.contentView addSubview:_textLabel];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    _textLabel.frame = self.contentView.bounds;
}
@end
