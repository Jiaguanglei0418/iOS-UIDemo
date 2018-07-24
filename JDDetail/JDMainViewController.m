//
//  JDMainViewController.m
//  JDDetail
//
//  Created by Guangleijia on 2018/7/19.
//  Copyright © 2018年 Reboot. All rights reserved.
//

#import "JDMainViewController.h"
#import "UIView+Extension.h"
#import "JDTitleView.h"
#import "NSObject+EOCNewKVO.h"
#import "JDProductViewController.h"

@interface JDMainViewController ()<UIScrollViewDelegate>
@property(nonatomic, strong)UIScrollView *mainScrollView;
@property(nonatomic, strong) JDTitleView *titleView;
@property(nonatomic, strong) JDProductViewController *productViewCtrl;
@end

@implementation JDMainViewController
- (JDProductViewController *)productViewCtrl {
    if (!_productViewCtrl) {
        _productViewCtrl = [[JDProductViewController alloc] init];
        [self addChildViewController:_productViewCtrl];
    }

    return _productViewCtrl;
}


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    if (@available(iOS 11, *)) {
        self.mainScrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    } else {
#pragma clang diagnostic push
#pragma clang diagnostic ignored"-Wdeprecated-declarations"
        self.automaticallyAdjustsScrollViewInsets = NO;
#pragma clang diagnostic pop

    }
    
    [self.view addSubview:self.mainScrollView];
    
//    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0.f, 0.f, self.view.width, self.view.height)];
//    scrollView.contentSize = CGSizeMake(self.view.width, self.view.height*2);
//    scrollView.backgroundColor = [UIColor yellowColor];
//    [self.mainScrollView addSubview:scrollView];
//
//    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0.f, 0.f, self.view.width, self.view.width)];
//    imageView.image = [UIImage imageNamed:@"product_0"];
//    [scrollView addSubview:imageView];
    
    [self customNavView];
    
    [self.mainScrollView addSubview:self.productViewCtrl.view];
}


- (void)customNavView {
    
    CGFloat btnHeight = 44.f;
    CGFloat btnWidth = 40.f;
    CGFloat btnSpace = 20.f;
    
    NSArray *titleArr = @[@"商品", @"详情", @"评价"];
    
    _titleView = [[JDTitleView alloc] initWithFrame:CGRectMake(0.f, 0.f, btnWidth*3+2*btnSpace, btnHeight)];
    _titleView.titleArr = titleArr;
    self.navigationItem.titleView = _titleView;
    
    __weak typeof(self)weakSelf = self;
    _titleView.btnActionBlock = ^(int index){
        
        [weakSelf.mainScrollView scrollRectToVisible:CGRectMake(index*weakSelf.view.width, 0.f, weakSelf.view.width, weakSelf.view.height) animated:YES];
        
    };
    
    //titleView添加对mainScrollView的观察
    __weak typeof(_titleView)weakTitleView = _titleView;
    [_titleView eocObserver:_mainScrollView keyPath:@"contentOffset" block:^{
        
        UIScrollView *scrollView = (UIScrollView *)weakSelf.mainScrollView;
        CGFloat xOffset = scrollView.contentOffset.x;
        CGFloat screenWidth = [[UIScreen mainScreen] bounds].size.width;
        //        int index = xOffset/screenWidth;  如果用这个数值，往右滑没问题，但往左滑有问题，可以算一下边界，左边随便移动一下，index值就改变了
        
        int index;
        if (xOffset == screenWidth) {
            
            index = 1;
            weakTitleView.indicatorLabel.transform = CGAffineTransformMakeTranslation(index*(btnWidth+btnSpace), 0.f);
            
        } else if (xOffset == 2*screenWidth) {
            
            index = 2;
            weakTitleView.indicatorLabel.transform = CGAffineTransformMakeTranslation(index*(btnWidth+btnSpace), 0.f);
            
        } else if (xOffset == 0) {
            
            index = 0;
            weakTitleView.indicatorLabel.transform = CGAffineTransformMakeTranslation(index*(btnWidth+btnSpace), 0.f);
            
        }
        
    }];
    
    
    //新建分享和更多两个按钮，注意如果使用[[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"share"] style:UIBarButtonItemStylePlain target:self action:@selector(shareAction)] 则不能调整大小、间距； 当然你也可以设置一个view 上面添加两个button
    
    //        UIBarButtonItem* shareButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"share"] style:UIBarButtonItemStylePlain target:self action:@selector(shareAction)];
    //
    //        UIBarButtonItem* moreButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"more"] style:UIBarButtonItemStylePlain target:self action:@selector(moreAction)];
    
    UIButton *shareBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    shareBtn.frame = CGRectMake(0.f, 0.f, 25.f, 25.f);
    [shareBtn setImage:[UIImage imageNamed:@"share"] forState:UIControlStateNormal];
    [shareBtn addTarget:self action:@selector(shareAction) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *shareButtonItem = [[UIBarButtonItem alloc] initWithCustomView:shareBtn];
    
    UIButton *moreBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    moreBtn.frame = CGRectMake(0.f, 0.f, 25.f, 25.f);
    [moreBtn setImage:[UIImage imageNamed:@"More"] forState:UIControlStateNormal];
    [moreBtn addTarget:self action:@selector(moreAction) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *moreButtonItem = [[UIBarButtonItem alloc] initWithCustomView:moreBtn];
    
    self.navigationItem.rightBarButtonItems = @[moreButtonItem, shareButtonItem];
    
}

#pragma mark - event response
- (void)shareAction {
    
    NSLog(@"分享");
    
}

- (void)moreAction {
    
    NSLog(@"更多");
    
}


#pragma mark - scrollViewDelegate
//- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
//    if (@available(iOS 11.0, *)) {
//        NSLog(@"safeAreaSize = %@", NSStringFromUIEdgeInsets(self.mainScrollView.safeAreaInsets));
//    } else {
//        // Fallback on earlier versions
//    }
//}


#pragma mark - getter方法
- (UIScrollView *)mainScrollView {
    
    if (!_mainScrollView) {
        
        //新建UIScrollView
        _mainScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0.f, 0.f, self.view.width, self.view.height)];
        _mainScrollView.backgroundColor = [UIColor redColor];
        _mainScrollView.contentSize = CGSizeMake(3*self.view.width, self.view.height-122.f);
        _mainScrollView.pagingEnabled = YES;
        _mainScrollView.bounces = NO;
        _mainScrollView.delegate = self;
        _mainScrollView.showsHorizontalScrollIndicator = YES;
        
    }
    
    return _mainScrollView;
}
@end
