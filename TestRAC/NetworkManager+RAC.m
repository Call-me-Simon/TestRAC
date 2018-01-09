//
//  NetworkManager+RAC.m
//  TestRAC
//
//  Created by Simon on 2018/1/8.
//  Copyright © 2018年 Simon. All rights reserved.
//

#import "NetworkManager+RAC.h"

@implementation NetworkManager (RAC)

#pragma mark --- RAC GET请求
+ (RACSignal *)RAC_GET:(NSString *)hosturl parameters:(NSDictionary *)params
{
    __weak typeof(self) weakSelf = self;
    return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
        [weakSelf POST:hosturl parameters:params success:^(NSURLSessionDataTask *task, id responseObject) {
            NSError *jsonError = nil;
            NSDictionary *responseDic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:&jsonError];
            if ([responseDic isKindOfClass:[NSDictionary class]] && !jsonError) {
                NSString *errorCode = responseDic[@"Status"];
                if ([errorCode isEqualToString:@"0"]) {
                    [subscriber sendNext:responseDic];
                    [subscriber sendCompleted];
                }else{
                    [subscriber sendError:[NSError errorWithDomain:responseDic[@"Explain"] code:errorCode.integerValue userInfo:@{NSLocalizedDescriptionKey : responseDic[@"Explain"] ? : @"未知网络错误"}]];
                }
            }else{
                [subscriber sendError:jsonError];
            }
        } failure:^(NSURLSessionDataTask *task, NSError *error) {
            [subscriber sendError:error];
        }];
        return [RACDisposable disposableWithBlock:^{}];
    }];
}

#pragma mark --- RAC POST请求
+ (RACSignal *)RAC_POST:(NSString *)hosturl parameters:(NSDictionary *)params
{
    __weak typeof(self) weakSelf = self;
    return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
       
        [weakSelf POST:hosturl parameters:params success:^(NSURLSessionDataTask *task, id responseObject) {
            NSError *jsonError = nil;
            NSDictionary *responseDic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:&jsonError];
            if ([responseDic isKindOfClass:[NSDictionary class]] && !jsonError) {
                NSString *errorCode = responseDic[@"Status"];
                if ([errorCode isEqualToString:@"0"]) {
                    [subscriber sendNext:responseDic];
                    [subscriber sendCompleted];
                }else{
                    [subscriber sendError:[NSError errorWithDomain:responseDic[@"Explain"] code:errorCode.integerValue userInfo:@{NSLocalizedDescriptionKey : responseDic[@"Explain"] ? : @"未知网络错误"}]];
                }
            }else{
                [subscriber sendError:jsonError];
            }
        } failure:^(NSURLSessionDataTask *task, NSError *error) {
            [subscriber sendError:error];
        }];
        return [RACDisposable disposableWithBlock:^{}];
    }];
}

@end
