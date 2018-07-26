//
//  JDTransitonSystemViewController.m
//  JDDetail
//
//  Created by Guangleijia on 2018/7/25.
//  Copyright © 2018年 Reboot. All rights reserved.
//

#import "JDTransitonSystemViewController.h"
#import <objc/message.h>
@interface JDTransitonSystemViewController ()

@end

@implementation JDTransitonSystemViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor yellowColor];
    self.title = @"系统转场动画手势替换";
    
    // UIScreenEdgePanGestureRecognizer;
    //13810451366
    /** po self.navigationController.interactivePopGestureRecognizer
     <UIScreenEdgePanGestureRecognizer: 0x7f9b82e05fa0; state = Possible; delaysTouchesBegan = YES; view = <UILayoutContainerView 0x7f9b85a09290>; target= <(action=handleNavigationTransition:, target=<_UINavigationInteractiveTransition 0x7f9b82e02760>)>>
     */
    NSArray *targets = [self.navigationController.interactivePopGestureRecognizer valueForKey:@"targets"];
    id target = [[targets lastObject] valueForKey:@"target"];
    SEL actionSel = NSSelectorFromString(@"handleNavigationTransition:");
    self.navigationController.interactivePopGestureRecognizer;
    
    
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:target action:actionSel];
    [self.view addGestureRecognizer:pan];
    
    
    [self scanMethods:NSClassFromString(@"UIScreenEdgePanGestureRecognizer")];
}


- (void)scanMethods:(Class)cls {
    unsigned int outCount = 0;
    Method *methods = class_copyMethodList(cls, &outCount);
    for (int i = 0; i< outCount; i++) {
        SEL sel = method_getName(methods[i]);
        NSLog(@"%@", NSStringFromSelector(sel));
    }
}


- (void)panMethod:(UIPanGestureRecognizer *)pan {
    NSLog(@"%@", pan);
    
    
}
@end
