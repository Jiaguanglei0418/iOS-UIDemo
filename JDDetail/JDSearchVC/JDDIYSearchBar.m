//
//  JDDIYSearchBar.m
//  JDDetail
//
//  Created by Guangleijia on 2018/7/24.
//  Copyright © 2018年 Reboot. All rights reserved.
//

#import "JDDIYSearchBar.h"

@implementation JDDIYSearchBar

- (instancetype)init {
    if (self = [super init]) {
        
        // 属性设置
        self.font = [UIFont systemFontOfSize:14.f];
        self.layer.cornerRadius = 5.f;
        self.backgroundColor = JDColor(240, 243, 245);
        
        self.placeholder = @"JDSearchBar";
        
        
        UIView *leftView = [[UIView alloc] initWithFrame:CGRectMake(0.f, 0.f, 28.f, 28.f)];
        
        UIImageView *searchIcon = [[UIImageView alloc] initWithFrame:CGRectMake(8.f, 7.5f, 13.f, 13.f)];
        searchIcon.image = [UIImage imageNamed:@"search_gray"];
        [leftView addSubview:searchIcon];
        
        self.leftView = leftView;
        self.leftViewMode = UITextFieldViewModeAlways;
        self.clearButtonMode = UITextFieldViewModeWhileEditing;
    }
    
    return self;
}

@end
