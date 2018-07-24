//
//  JDProductViewController.m
//  JDDetail
//
//  Created by Guangleijia on 2018/7/19.
//  Copyright © 2018年 Reboot. All rights reserved.
//

#import "JDProductViewController.h"
#import "JDProductScrollView.h"
#import "UIView+Extension.h"

@interface JDProductViewController ()<UIScrollViewDelegate>

@property(nonatomic, strong) UIView *contentView;
@property(nonatomic, strong) UIView *sonView;
@property(nonatomic, strong) UIScrollView *productMainScrollView;
@property(nonatomic, strong) JDProductScrollView *productScrollView;
//@property(nonatomic, strong) <#type#> *<#name#>

@end

@implementation JDProductViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.contentView];
    [self.contentView addSubview:self.productMainScrollView];
//    [self];
    
}


- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    NSLog(@"Offset=%@", NSStringFromCGPoint(scrollView.contentOffset));
}

#pragma mark - getter
- (UIView *)contentView {
    if (!_contentView) {
        _contentView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, self.view.height*2)];
        
        _contentView.backgroundColor = [UIColor purpleColor];
    }
    
    return _contentView;
}


- (UIScrollView *)productMainScrollView
{
    if (!_productMainScrollView) {
        _productMainScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0.f, 0.f, self.view.width, self.view.height)];
        _productMainScrollView.showsVerticalScrollIndicator = YES;
        _productMainScrollView.backgroundColor = [UIColor yellowColor];
        _productMainScrollView.delegate = self;
        _productMainScrollView.contentSize = CGSizeMake(self.view.width, self.view.height * 2);
        _productMainScrollView.delegate =self;
        
        [_productMainScrollView addSubview:self.productScrollView];
    }
    return _productMainScrollView;
}

- (JDProductScrollView *)productScrollView
{
    if (!_productScrollView) {
        NSArray *imageArray = @[@"product_1", @"product_0", @"product_1", @"product_0", @"product_1", @"product_0"];
        
        _productScrollView = [[JDProductScrollView alloc] initWithFrame:CGRectMake(0.f, 0.f, self.view.width, self.view.width)];
        _productScrollView.backgroundColor = [UIColor redColor];
        _productScrollView.imageArray = imageArray;
    }
    return _productScrollView;
}

@end
