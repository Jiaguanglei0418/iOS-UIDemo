//
//  JDDIYButton.m
//  JDDetail
//
//  Created by Guangleijia on 2018/7/24.
//  Copyright © 2018年 Reboot. All rights reserved.
//

#import "JDDIYButton.h"

@implementation JDDIYButton

//addSubView会调用、frame改变的时候会调用
- (void)layoutSubviews {
    
    [super layoutSubviews];
    
    NSLog(@"111");
    
    //bool值默认都是为NO
    if (!_noImage) {
        
        self.imageView.frame = CGRectMake(6.f, 0.f, self.width-12.f, self.width-12.f);
        self.titleLabel.frame = CGRectMake(0.f, self.height-12.f, self.width, 12.f);
        
        self.titleLabel.font = [UIFont systemFontOfSize:9.f];
        
    } else { // 没有 image
        
        self.imageView.frame = CGRectZero;
        self.titleLabel.frame = CGRectMake(0.f, 0.f, self.width, self.height);
        self.titleLabel.font = [UIFont systemFontOfSize:14.f];
        
    }
    
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    self.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
}
@end
