//
//  JDHorizonalScrollView.m
//  JDDetail
//
//  Created by Guangleijia on 2018/7/19.
//  Copyright © 2018年 Reboot. All rights reserved.
//

#import "JDHorizonalScrollView.h"

@implementation JDHorizonalScrollView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.panGestureRecognizer.delegate = self;
        
        //
        _isOpen = YES;
    }
    
    return self;
}

#pragma mark - 重写手势代理，如果是右滑，则禁用掉mainScrollView自带的
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
    if ([gestureRecognizer isKindOfClass:[UIPanGestureRecognizer class]]) {
        // 这里的判断 pointX<0 不是重复判断, 如果不做这个判断, 你会发现滑到最后一个的时候, 再往后滑就滑不动了
        UIPanGestureRecognizer *pan = (UIPanGestureRecognizer *)gestureRecognizer;
        CGFloat pointX = [pan translationInView:self].x;
        if (pointX < 0 && !_isOpen) {
            return NO;
        }
        
    }
    return YES;
}
@end
