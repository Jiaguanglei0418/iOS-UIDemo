

//
//  JDDIYNavAnimation.m
//  JDDetail
//
//  Created by Guangleijia on 2018/7/26.
//  Copyright © 2018年 Reboot. All rights reserved.
//

#import "JDDIYNavAnimation.h"

@implementation JDDIYNavAnimation{
    id <UIViewControllerContextTransitioning> _transitionContext;
}

// 时间
// This is used for percent driven interactive transitions, as well as for
// container controllers that have companion animations that might need to
// synchronize with the main animation.
- (NSTimeInterval)transitionDuration:(nullable id <UIViewControllerContextTransitioning>)transitionContext {
    
    return 0.2f;
}

// 过程
// This method can only  be a nop if the transition is interactive and not a percentDriven interactive transition.
- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext {
    _transitionContext = transitionContext;
    // 获取 toView    fromView
    UIViewController *toVC = [transitionContext viewControllerForKey: UITransitionContextToViewControllerKey];
    UIViewController *fromVC = [transitionContext viewControllerForKey: UITransitionContextFromViewControllerKey];
    
    UIView *toView = [transitionContext viewForKey: UITransitionContextToViewKey];
    UIView *fromView = [transitionContext viewForKey: UITransitionContextFromViewKey];
    
//    UIView *toView = toVC.view;
//    UIView *fromView = fromVC.view;
    
    UIView *transferView = [transitionContext containerView];
    [transferView insertSubview:toView belowSubview:fromView];
    
    
//    [UIView animateWithDuration:[self transitionDuration:transitionContext]
//                     animations:^{
//        fromVC.view.frame = CGRectMake(fromView.width, fromView.y, fromView.width, fromView.height);
//
//
//    } completion:^(BOOL finished) {
//        // 务必结束
//        [transitionContext completeTransition:YES];
//    }];
    
//    [self addDiyAniamtionForView:transferView];
    [self addDiyAniamtionForView:transferView];
}

- (void)addDiyAniamtionForView:(UIView *)view {
    CATransition *tran = [[CATransition alloc] init];
    tran.type = @"cube";
    tran.subtype = @"fromLeft";
    tran.duration = .35;
    tran.fillMode = kCAFillModeForwards;
    tran.removedOnCompletion = NO;
    tran.delegate = self;
    
    [view.layer addAnimation:tran forKey:nil];
    [view exchangeSubviewAtIndex:0 withSubviewAtIndex:1];
}


//@optional
// 中断处理
/// A conforming object implements this method if the transition it creates can
/// be interrupted. For example, it could return an instance of a
/// UIViewPropertyAnimator. It is expected that this method will return the same
/// instance for the life of a transition.
//- (id <UIViewImplicitlyAnimating>) interruptibleAnimatorForTransition:(id <UIViewControllerContextTransitioning>)transitionContext {
//
//
//}

// context结束
// This is a convenience and if implemented will be invoked by the system when the transition context's completeTransition: method is invoked.
- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag{
    
    [_transitionContext completeTransition:YES];
}


- (void)dealloc {
    NSLog(@"JDDIYNavAnimation - %s", __FUNCTION__);
}

@end
