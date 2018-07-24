//
//  ViewController.m
//  JDDetail
//
//  Created by Guangleijia on 2018/7/19.
//  Copyright © 2018年 Reboot. All rights reserved.
//

#import "ViewController.h"
#import "UIView+Extension.h"
#import "JDMainViewController.h"
#import "JDTableViewController.h"
#import "JDCollectionViewController.h"
#import "JDSearchViewController.h"
@interface ViewController ()
@property(nonatomic, strong) UIButton *pushBtn;
@property(nonatomic, strong) JDMainViewController *mainVC;

@end

@implementation ViewController
- (UIButton *)pushBtn
{
    if (!_pushBtn) {
        _pushBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 200, 50)];
        [_pushBtn setTitle:@"push" forState:UIControlStateNormal];
        _pushBtn.backgroundColor = [UIColor brownColor];
        [_pushBtn addTarget:self action:@selector(pushMethod:) forControlEvents:UIControlEventTouchUpInside];
        _pushBtn.center = self.view.center;
    }
    return _pushBtn;
}


- (JDMainViewController *)mainVC {
    if (!_mainVC) {
//        _mainVC = [[JDMainViewController alloc] init];
    }
    return _mainVC;
}

- (void)pushMethod:(id)sender {
    
//    [self.navigationController pushViewController:self.mainVC animated:YES];
//     [self.navigationController pushViewController:[JDTableViewController new] animated:YES];
    [self.navigationController pushViewController:[JDSearchViewController new] animated:YES];
    
//    NSRange range= [[NSCalendar currentCalendar] rangeOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitMonth forDate:[NSDate date]];
//    NSLog(@"range-%@", NSStringFromRange(range));
//    
//   
//    NSUInteger integ = [[NSCalendar currentCalendar] ordinalityOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitWeekOfMonth forDate:[[NSDate date] dateByAddingTimeInterval:60*60*24]];
//    NSLog(@"inte = %ld", integ);
//    
//    NSDate *startDate = nil;
//    NSTimeInterval interval = 0;
//    
//    BOOL ok = [[NSCalendar currentCalendar] rangeOfUnit:NSCalendarUnitMonth startDate:&startDate interval:&interval forDate:[NSDate date]];
//    NSLog(@"%@---%lf", startDate, interval);
    
//    - (NSRange)rangeOfUnit:(NSCalendarUnit)smaller inUnit:(NSCalendarUnit)larger forDate:(NSDate *)date;
//    - (NSUInteger)ordinalityOfUnit:(NSCalendarUnit)smaller inUnit:(NSCalendarUnit)larger forDate:(NSDate *)date;
    
}

- (void)viewWillAppear:(BOOL)animated {
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    
    [super viewWillAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated {
    [self.navigationController setNavigationBarHidden:NO animated:NO];
    
    [super viewDidDisappear:animated];
}

- (void)viewDidLoad {
    self.view.backgroundColor = [UIColor whiteColor];
    
    
    UINavigationBar *bar = [[UINavigationBar alloc] initWithFrame:CGRectMake(0, 0, self.view.width, 200.f)];
    bar.barTintColor = [UIColor redColor];
    bar.prefersLargeTitles = YES;
    [self.view addSubview:bar];
    
    [super viewDidLoad];
    
    
    [self.view addSubview:self.pushBtn];
    
    
}



@end
