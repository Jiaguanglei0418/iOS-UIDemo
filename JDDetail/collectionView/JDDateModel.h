//
//  JDDateModel.h
//  JDDetail
//
//  Created by Guangleijia on 2018/7/23.
//  Copyright © 2018年 Reboot. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JDDateModel : NSObject
- (NSInteger)totalDaysInMoothForString:(NSString *)string;
- (NSInteger)totalDaysInMoothForDate:(NSDate *)date;


+ (NSInteger)weekDayMonthOfFirstDayForDate:(NSDate *)date;
@end
