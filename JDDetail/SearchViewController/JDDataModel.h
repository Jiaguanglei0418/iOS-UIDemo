//
//  JDDataModel.h
//  JDDetail
//
//  Created by Guangleijia on 2018/7/24.
//  Copyright © 2018年 Reboot. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JDDataModel : NSObject

@property(nonatomic, strong) NSArray *dataArr;

+ (instancetype)sharedDataModel;

@end
