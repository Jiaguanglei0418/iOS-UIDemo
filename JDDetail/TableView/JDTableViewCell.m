//
//  JDTableViewCell.m
//  JDDetail
//
//  Created by Guangleijia on 2018/7/23.
//  Copyright © 2018年 Reboot. All rights reserved.
//

#import "JDTableViewCell.h"

@implementation JDTableViewCell
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        _textLabel = [UILabel new];
        _textLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_textLabel];
    }
    return self;
}

- (instancetype)initWithIdentifier:(NSString *)identifier {
    if (self = [super init]) {
        _reuseID = identifier;
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    _textLabel.frame = self.bounds;
}

@end
