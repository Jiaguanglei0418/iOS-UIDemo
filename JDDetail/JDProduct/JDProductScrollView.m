//
//  JDProductScrollView.m
//  JDDetail
//
//  Created by Guangleijia on 2018/7/19.
//  Copyright © 2018年 Reboot. All rights reserved.
//

#import "JDProductScrollView.h"
#import "UIView+Extension.h"
#import "JDHorizonalScrollView.h"
#import "UIView+Size.h"


@interface JDProductScrollView ()<UIScrollViewDelegate> {
    CGFloat lastXoffset;
}

@property(nonatomic, strong) JDHorizonalScrollView *productImageScrollView;
@property(nonatomic, strong) UIImageView *leftImageView;
@property(nonatomic, strong) UIImageView *centerImageView;
@property(nonatomic, strong) UIImageView *rightImageView;
@property(nonatomic, assign) NSInteger currentIndex;

@end

@implementation JDProductScrollView
static const int pageNum = 3;

- (instancetype)initWithFrame:(CGRect)frame {
    if(self = [super initWithFrame:frame]){
        self.backgroundColor = [UIColor whiteColor];

        [self addSubview:self.productImageScrollView];
        _currentIndex = 0;
    }
    return self;
}

- (void)setImageArray:(NSArray *)imageArray {
    _imageArray = imageArray;

    [self.productImageScrollView addSubview:self.leftImageView];
    [self.productImageScrollView addSubview:self.centerImageView];
    [self.productImageScrollView addSubview:self.rightImageView];
}

///** 设置 subView 的 x, 达到覆盖效果 */
- (void)setOriginXForView:(UIView *)subView
                fromStart:(CGFloat)start
                 byOffset:(CGFloat)byOffset {

    CGRect tempFrame = subView.frame;
    tempFrame.origin.x = start + byOffset*0.5;
    subView.frame = tempFrame;
}


/** 设置 currentIndex */
- (void)resetCurrentIndex:(CGFloat)xOffset {

    CGFloat halfWidth = self.width*0.5;
    if (xOffset < halfWidth && lastXoffset >= halfWidth) { // 右->左: 1-0
        self.currentIndex--;
    }else if (xOffset > halfWidth && lastXoffset <= halfWidth) { // 左->右: 0-1
        self.currentIndex++;
    }else if (xOffset < 3*halfWidth && lastXoffset >= 3*halfWidth){
        self.currentIndex--;
    }else if (xOffset > 3*halfWidth && lastXoffset <= 3*halfWidth){ // 左->右: 1-2 ->
        self.currentIndex++;
    }
}


- (void)resetImages {
    CGFloat halfWidth = self.width*0.5;
    self.leftImageView.image = [UIImage imageNamed:self.imageArray[_currentIndex-1]];
    self.leftImageView.frame = CGRectMake(halfWidth, 0.f, self.width, self.height);

    self.centerImageView.image = [UIImage imageNamed:self.imageArray[_currentIndex]];
    self.centerImageView.frame = CGRectMake(self.width, 0.f, self.width, self.height);

    self.rightImageView.image = [UIImage imageNamed:self.imageArray[_currentIndex+1]];
    self.rightImageView.frame = CGRectMake(self.width*2, 0.f, self.width, self.height);

    lastXoffset = self.width;

    // 把 contentOffset 变成中间的值
    [self.productImageScrollView scrollRectToVisible:CGRectMake(self.width, 0.f, self.width, self.height) animated:NO];

}


#pragma mark - scrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {

    CGFloat xOffset = scrollView.contentOffset.x;
    NSLog(@"Offset=%@", NSStringFromCGPoint(scrollView.contentOffset));

    if (xOffset < self.width) {
        [self setOriginXForView:self.leftImageView
                      fromStart:0.f
                       byOffset:xOffset];
    } else if(xOffset > self.width){
        [self setOriginXForView:self.centerImageView
                      fromStart:self.width
                       byOffset:(xOffset-self.width)];
    }

    // 内容是根据 currentIndex 计算出来的
    [self resetCurrentIndex:xOffset];
    lastXoffset = xOffset;


    ///手势的互斥
//    BOOL isLeft = [scrollView.panGestureRecognizer translationInView:self].x < 0?YES:NO;
//    if (_currentIndex == _imageArray.count-1 && isLeft) {  //最右边的图片，而且往左滑动
//
//        _productImageScrollView.isOpen = NO;
//
//    } else {
//
//        _productImageScrollView.isOpen = YES;
//
//    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    if (_currentIndex > 0 && _currentIndex < _imageArray.count-1) {
        [self resetImages];
    }
}


#pragma mark - Getter
- (JDHorizonalScrollView *)productImageScrollView
{
    if (!_productImageScrollView) {
        _productImageScrollView = [[JDHorizonalScrollView alloc] initWithFrame:CGRectMake(0.f, 0.f, self.width, self.height)];
        // contentSize: 如果不设置高度, 会导致滑动第三章报错
        _productImageScrollView.contentSize = CGSizeMake(self.width*pageNum, self.height);
        _productImageScrollView.backgroundColor = [UIColor cyanColor];
        _productImageScrollView.pagingEnabled = YES;
        _productImageScrollView.bounces = YES;
        _productImageScrollView.showsHorizontalScrollIndicator = NO;
        _productImageScrollView.delegate = self;

    }
    return _productImageScrollView;
}

- (UIImageView *)leftImageView
{
    if (!_leftImageView) {
        _leftImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:_imageArray[_currentIndex]]];
        _leftImageView.frame = CGRectMake(0.f, 0.f, self.width, self.height);
        _leftImageView.userInteractionEnabled = YES;
    }
    return _leftImageView;
}

- (UIImageView *)centerImageView
{
    if (!_centerImageView) {
        _centerImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:_imageArray[_currentIndex+1]]];
        _centerImageView.frame = CGRectMake(self.width, 0.f, self.width, self.height);
        _centerImageView.userInteractionEnabled = YES;
    }
    return _centerImageView;
}

- (UIImageView *)rightImageView
{
    if (!_rightImageView) {
        _rightImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:_imageArray[_currentIndex+2]]];
        _rightImageView.frame = CGRectMake(self.width*2, 0.f, self.width, self.height);
        _rightImageView.userInteractionEnabled = YES;
    }
    return _rightImageView;
}

@end
