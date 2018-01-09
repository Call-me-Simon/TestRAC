//
//  NetworkManager+RAC.h
//  TestRAC
//
//  Created by Simon on 2018/1/8.
//  Copyright © 2018年 Simon. All rights reserved.
//

#import "NetworkManager.h"

@interface NetworkManager (RAC)

#pragma mark --- RAC GET请求
+ (RACSignal *)RAC_GET:(NSString *)hosturl parameters:(NSDictionary *)params;

#pragma mark --- RAC POST请求
+ (RACSignal *)RAC_POST:(NSString *)hosturl parameters:(NSDictionary *)params;

@end
