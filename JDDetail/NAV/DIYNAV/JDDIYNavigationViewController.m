//
//  JDDIYNavigationViewController.m
//  JDDetail
//
//  Created by Guangleijia on 2018/7/26.
//  Copyright © 2018年 Reboot. All rights reserved.
//

#import "JDDIYNavigationViewController.h"
#import "JDDIYNavAnimation.h"
//#import "EOCNavAnimation.h"

@interface JDDIYNavigationViewController ()<UINavigationControllerDelegate> {
    UIPercentDrivenInteractiveTransition *_percentDrivenAnimation;
}


@end

@implementation JDDIYNavigationViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.delegate = self;
    
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panMethod:)];
    [self.view addGestureRecognizer:pan];
    
}

- (void)panMethod:(UIPanGestureRecognizer *)pan {
 
    // 获取移动距离
    CGPoint movePoint = [pan translationInView:self.view];
    // 清空, 否则会累加
//    [pan setTranslation:CGPointZero inView:self.view];
    NSLog(@"%@", NSStringFromCGPoint(movePoint));
    
    float percent = movePoint.x / kScreenWidth;
    
    if (pan.state == UIGestureRecognizerStateBegan) {
         _percentDrivenAnimation = [[UIPercentDrivenInteractiveTransition alloc] init];
    }else if (pan.state == UIGestureRecognizerStateChanged){
        [_percentDrivenAnimation updateInteractiveTransition:percent];
    }else{
        [self popViewControllerAnimated:YES];
        NSLog(@"complete - %lf", _percentDrivenAnimation.percentComplete);
        if (percent > 0.5) {
            [_percentDrivenAnimation finishInteractiveTransition];
        }else {
            [_percentDrivenAnimation cancelInteractiveTransition];
        }
        _percentDrivenAnimation = nil;
    }
    
    
}
#pragma mark - navDelegate
//- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
//
//}
//
//- (void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
//
//}

//- (UIInterfaceOrientationMask)navigationControllerSupportedInterfaceOrientations:(UINavigationController *)navigationController {
//    
//    
//}

//- (UIInterfaceOrientation)navigationControllerPreferredInterfaceOrientationForPresentation:(UINavigationController *)navigationController {
//
//}


// 返回动画进度对象
- (nullable id <UIViewControllerInteractiveTransitioning>)navigationController:(UINavigationController *)navigationController
                                   interactionControllerForAnimationController:(id <UIViewControllerAnimatedTransitioning>) animationController {
    
    if ([animationController isKindOfClass:[JDDIYNavAnimation class]]) {
        
        
        return _percentDrivenAnimation;
    }
    return nil;
}


// 返回动画对象
//- (nullable id <UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController
//                                            animationControllerForOperation:(UINavigationControllerOperation)operation
//                                                         fromViewController:(UIViewController *)fromVC
//                                                           toViewController:(UIViewController *)toVC {
//
//
//    if (operation == UINavigationControllerOperationPop) {
//        return [[JDDIYNavAnimation alloc] init];
//    }
//    return nil;
//}



// 返回动画进度对象 (根据触摸手势移动距离, 控制界面状态)
//- (nullable id <UIViewControllerInteractiveTransitioning>)navigationController:(UINavigationController *)navigationController
//                                   interactionControllerForAnimationController:(id <UIViewControllerAnimatedTransitioning>) animationController {
//    if ([animationController isKindOfClass:[JDDIYNavAnimation class]]) {
//
//        return _percentDrivenAnimation;
//    }
//
//    return nil;
//}

// 返回动画对象
- (nullable id <UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController
                                            animationControllerForOperation:(UINavigationControllerOperation)operation
                                                         fromViewController:(nonnull UIViewController *)fromVC toViewController:(nonnull UIViewController *)toVC
{
    if (operation == UINavigationControllerOperationPop) {
        return [[JDDIYNavAnimation alloc] init];
    }
    return nil;
}
@end
