//
//  JDTitleView.m
//  JDDetail
//
//  Created by Guangleijia on 2018/7/19.
//  Copyright © 2018年 Reboot. All rights reserved.
//

#import "JDTitleView.h"
#import "UIView+Extension.h"

@interface JDTitleView () {
    
    CGAffineTransform originalTransform;
    
}

@end
@implementation JDTitleView

static const CGFloat btnWidth = 40.f;
static const CGFloat btnSpace = 20.f;

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = [UIColor clearColor];
        self.scrollEnabled = NO;
        self.contentSize = CGSizeMake(frame.size.width, 2*frame.size.height);
        
    }
    
    return self;
}

- (void)setTitleArr:(NSArray *)titleArr {
    
    _titleArr = titleArr;
    
    //创建titleView
    for (int i=0; i<3; i++) {
        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(i*(btnWidth+btnSpace), 0.f, btnWidth, 44.f);
        [btn setTitle:titleArr[i] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
        btn.accessibilityValue = [NSString stringWithFormat:@"%d", i];
        btn.titleLabel.font = [UIFont systemFontOfSize:17.f];
        [self addSubview:btn];
        
        //添加黑色指示label
        if (i == 0) {
            
            [self addSubview:self.indicatorLabel];
            _indicatorLabel.frame = ({
                CGRect frame = btn.frame;
                frame.origin.y = btn.frame.size.height-2;
                frame.size.height = 2.f;
                frame;
            });
            originalTransform = _indicatorLabel.transform;
            
        }
        
    }
    
    //添加图文详情nextTitleView和文字的titleLabel
    UIView *nextTitleView = [[UIView alloc] initWithFrame:CGRectMake(0.f, 44.f, btnWidth*3+2*btnSpace, 44.f)];
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0.f, 0.f, nextTitleView.width, nextTitleView.height)];
    titleLabel.text = @"图文详情";
    titleLabel.textColor = [UIColor blackColor];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    [nextTitleView addSubview:titleLabel];
    [self addSubview:nextTitleView];
    
}

//#pragma mark - 观察scrollView 偏移量
//- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
//{
//    if ([keyPath isEqualToString:@"contentOffset"]) {
//
//        UIScrollView *scrollView = (UIScrollView *)object;
//        CGFloat xOffset = scrollView.contentOffset.x;
//        CGFloat screenWidth = [[UIScreen mainScreen] bounds].size.width;
//        //        int index = xOffset/screenWidth;  如果用这个数值，往右滑没问题，但往左滑有问题，可以算一下边界，左边随便移动一下，index值就改变了
//
//        int index;
//        if (xOffset == screenWidth) {
//
//            index = 1;
//            _indicatorLabel.transform = CGAffineTransformTranslate(originalTransform, index*(btnWidth+btnSpace), 0.f);
//
//        } else if (xOffset == 2*screenWidth) {
//
//            index = 2;
//            _indicatorLabel.transform = CGAffineTransformTranslate(originalTransform, index*(btnWidth+btnSpace), 0.f);
//
//        } else if (xOffset == 0) {
//
//            index = 0;
//            _indicatorLabel.transform = CGAffineTransformTranslate(originalTransform, index*(btnWidth+btnSpace), 0.f);
//
//        }
//
//
//    }
//
//}

#pragma mark - event response
- (void)btnAction:(UIButton *)btn {
    
    int index = btn.accessibilityValue.intValue;
    //    _indicatorLabel.transform = CGAffineTransformMakeTranslation(index*(btnWidth+btnSpace), 0.f);
    //    _indicatorLabel.transform = CGAffineTransformTranslate(originalTransform, index*(btnWidth+btnSpace), 0.f);
    //    originalTransform = _indicatorLabel.transform;
    
    if (_btnActionBlock) {
        
        _btnActionBlock(index);
    }
    
}

#pragma mark - getter method
- (UILabel *)indicatorLabel {
    
    if (!_indicatorLabel) {
        
        _indicatorLabel = [[UILabel alloc] init];
        _indicatorLabel.backgroundColor = [UIColor blackColor];
        
    }
    return _indicatorLabel;
}
@end
