//
//  PrefixHeader.h
//  JDDetail
//
//  Created by Guangleijia on 2018/7/24.
//  Copyright © 2018年 Reboot. All rights reserved.
//

#ifndef PrefixHeader_h
#define PrefixHeader_h

#define kScreenWidth     [UIScreen mainScreen].bounds.size.width
#define kScreenHeight    [UIScreen mainScreen].bounds.size.height

#define JD_iPhoneX (kScreenWidth == 375.f && kScreenHeight == 812.f ? YES : NO)
#define kNavigationBarHeight    (JD_iPhoneX ? 88.f : 64.f)
#define kStatusBarHeight        (JD_iPhoneX ? 44.f : 20.f)


#define JDColor(r,g,b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]

#import "UIView+Extension.h"
#import "UIViewController+lifeCircle.h"


#endif /* PrefixHeader_h */
