//
//  JDDateModel.m
//  JDDetail
//
//  Created by Guangleijia on 2018/7/23.
//  Copyright © 2018年 Reboot. All rights reserved.
//

#import "JDDateModel.h"
/**
    2018-07-20 YYYY-MM-dd
 */
@implementation JDDateModel
- (NSInteger)totalDaysInMoothForString:(NSString *)string{
    // GMT 东八区 少了八个小时
    NSDateFormatter *formater = [[NSDateFormatter alloc] init];
    [formater setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:0]];
    [formater setDateFormat:@"YYYY-MM-dd"];
    
    NSDate *date = [formater dateFromString:string];
    return [self totalDaysInMoothForDate:date];
}
- (NSInteger)totalDaysInMoothForDate:(NSDate *)date{

    NSRange dayRange = [[NSCalendar currentCalendar] rangeOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitMonth forDate:date];
    return dayRange.length;
}



+ (NSInteger)weekDayMonthOfFirstDayForDate:(NSDate *)date {
//    [[NSCalendar currentCalendar]]
    
    NSDate *startDate = nil;
    NSTimeInterval inverval = 0;
    BOOL ok = [[NSCalendar currentCalendar] rangeOfUnit:NSCalendarUnitMonth startDate:&startDate interval:&inverval forDate:date];
    
    if (ok) {
        NSInteger firstDay = [[NSCalendar currentCalendar] ordinalityOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitWeekOfMonth forDate:startDate];
        return firstDay;
    }
    
    return 0;
}

@end
