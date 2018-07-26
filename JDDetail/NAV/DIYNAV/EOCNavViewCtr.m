//
//  EOCNavViewCtr.m
//  NavApply
//
//  Created by sy on 2017/10/16.
//  Copyright © 2017年 EOC. All rights reserved.
//

/*
 作业：
 1 runtime 观察私有方法（了解私有的类）（手势+tranferView）
 2 push
 3 导航条动画
 */

#import "EOCNavViewCtr.h"
//#import "EOCNavAnimation.h"
#import "JDDIYNavAnimation.h"
@interface EOCNavViewCtr ()<UINavigationControllerDelegate>{
    
    UIPercentDrivenInteractiveTransition *percentAnimation;
}

@end

@implementation EOCNavViewCtr

- (void)viewDidLoad {
    
    [super viewDidLoad];
   
    self.delegate = self;
    
    UIPanGestureRecognizer *panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panGesture:)];
    [self.view addGestureRecognizer:panGesture];
    
}

- (void)panGesture:(UIPanGestureRecognizer*)gesture{

    // 获取 当前view（fromview）  pop的view（toView）


    CGPoint movePoint = [gesture translationInView:self.view];
    float precent = movePoint.x/[UIScreen mainScreen].bounds.size.width;

    if (gesture.state == UIGestureRecognizerStateBegan) {

        percentAnimation = [[UIPercentDrivenInteractiveTransition alloc] init];
        [self popViewControllerAnimated:YES];

    }else if (gesture.state == UIGestureRecognizerStateChanged){

        [percentAnimation updateInteractiveTransition:precent];
    }else {

        if (percentAnimation.percentComplete > 0.5) {
            [percentAnimation finishInteractiveTransition];
        }else {
            [percentAnimation cancelInteractiveTransition];
        }
        percentAnimation = nil;
    }


}

// 返回动画进度对象
- (nullable id <UIViewControllerInteractiveTransitioning>)navigationController:(UINavigationController *)navigationController
                                   interactionControllerForAnimationController:(id <UIViewControllerAnimatedTransitioning>) animationController {

    if ([animationController isKindOfClass:[JDDIYNavAnimation class]]) {


        return percentAnimation;
    }
    return nil;
}

// 返回动画对象
- (nullable id <UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController
                                            animationControllerForOperation:(UINavigationControllerOperation)operation
                                                         fromViewController:(UIViewController *)fromVC
                                                           toViewController:(UIViewController *)toVC {
    
    
    if (operation == UINavigationControllerOperationPop) {
        return [[JDDIYNavAnimation alloc] init];
    }
    return nil;
}


@end
