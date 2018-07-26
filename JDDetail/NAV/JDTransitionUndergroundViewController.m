//
//  JDTransitionUndergroundViewController.m
//  JDDetail
//
//  Created by Guangleijia on 2018/7/25.
//  Copyright © 2018年 Reboot. All rights reserved.
//

#import "JDTransitionUndergroundViewController.h"

@interface JDTransitionUndergroundViewController ()

@end

@implementation JDTransitionUndergroundViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor greenColor];
    self.title = @"转场动画解析";

    
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panMethod:)];
    [self.view addGestureRecognizer:pan];
}
- (void)viewDidAppear:(BOOL)animated {
    NSLog(@"before - %s", __FUNCTION__);
    [super viewDidAppear:animated];
    NSLog(@"after - %s", __FUNCTION__);
}
/**
 1. 当前控制器 view 坐标移动;
 2. 下一个控制 view 坐标移动;
 
 ???
 A push B
 B 的 ViewDidAppear 在 A 的 ViewDidDisappear 之前执行
 
 */
- (void)panMethod:(UIPanGestureRecognizer *)pan {
    UIView *containerView = [self.view superview];
    
    // 获取当前控制器的 View (fromView)  pop 的View(toView)
    UIView *fromView = self.view;
    UIView *toView = nil;
    
    NSArray *VCS = self.navigationController.viewControllers;
    if (VCS.count >=2 ) {
        UIViewController *toViewCon = VCS[VCS.count-2];
        toView = toViewCon.view;
    }
    
    [containerView insertSubview:toView belowSubview:fromView];
    
    // 获取移动距离
    CGPoint movePoint = [pan translationInView:self.view];
    // 清空, 否则会累加
    [pan setTranslation:CGPointZero inView:self.view];
    // 水平滑动距离
    float moveWidth = movePoint.x;
    moveWidth *= 0.8;
    
    NSLog(@"width = %lf", moveWidth);
    
    if (pan.state == UIGestureRecognizerStateBegan) {
        toView.frame = CGRectMake(-toView.width, toView.y, toView.width, toView.height);
    }else if (pan.state == UIGestureRecognizerStateChanged){
        toView.frame = CGRectMake(toView.x+moveWidth, toView.y, toView.width, toView.height);
        fromView.frame = CGRectMake(fromView.x+moveWidth, fromView.y, fromView.width, fromView.height);
        NSLog(@"from = %@\n to = %@", NSStringFromCGRect(fromView.frame), NSStringFromCGRect(toView.frame));
    }else{
        if (fromView.x > fromView.width*0.5) { //滑动一半, 开始 pop
            
            [UIView animateWithDuration:0.2 animations:^{
                fromView.frame = CGRectMake(fromView.width, fromView.y, fromView.width, fromView.height);
                toView.frame = CGRectMake(0, toView.y, toView.width, toView.height);
            } completion:^(BOOL finished) {
                // 移除
                NSMutableArray *vcArray = [NSMutableArray arrayWithArray:self.navigationController.viewControllers];
                [vcArray removeLastObject];
                self.navigationController.viewControllers = vcArray;
            }];
        }else{ // 还原
            [UIView animateWithDuration:0.1 animations:^{
                fromView.frame = CGRectMake(0, fromView.y, fromView.width, fromView.height);
                toView.frame = CGRectMake(-toView.width, toView.y, toView.width, toView.height);
            } completion:^(BOOL finished) {
                
            }];
        }
    }
    

}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    
}


@end
