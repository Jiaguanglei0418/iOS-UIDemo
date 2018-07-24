//
//  JDDataModel.m
//  JDDetail
//
//  Created by Guangleijia on 2018/7/24.
//  Copyright © 2018年 Reboot. All rights reserved.
//

#import "JDDataModel.h"

@implementation JDDataModel
static JDDataModel *__dataModel;

+ (instancetype)sharedDataModel {
    return __dataModel;
}

// 类初始化 一次
+ (void)initialize {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (!__dataModel) {
            __dataModel = [[JDDataModel alloc] init];
        }
    });
}


- (instancetype)init {
    if (!__dataModel) {
        if (self = [super init]) {
            NSString *path = [[NSBundle mainBundle] pathForResource:@"country" ofType:@"txt"];
            NSString *contriesContent = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
            _dataArr = [contriesContent componentsSeparatedByString:@"\n"];
        }
        return self;
    }
    return __dataModel;
}

@end
