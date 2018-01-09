//
//  NetworkManager.h
//  TestRAC
//
//  Created by Simon on 2018/1/8.
//  Copyright © 2018年 Simon. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AppConfig.h"

typedef void (^NetworkSuccess) (NSURLSessionDataTask * task, id responseObject);

typedef void (^NetworkFailure) (NSURLSessionDataTask * task, NSError * error);

typedef void (^NetworkResult) (id task, NSError *error);

typedef void (^UploadProgress) (float progress);

typedef void (^DownloadProgress) (float progress);

@interface NetworkManager : NSObject

+ (NSURLSessionDataTask *)GET:(NSString *)hosturl parameters:(NSDictionary *)params success:(NetworkSuccess)success failure:(NetworkFailure)failure;

+ (NSURLSessionDataTask *)POST:(NSString *)hosturl parameters:(NSDictionary *)params success:(NetworkSuccess)success failure:(NetworkFailure)failure;

#pragma mark --- 图片上传
+ (void)UploadImages:(NSArray *)imageArray
             hosturl:(NSString *)hosturl
          parameters:(NSDictionary *)params
         targetWidth:(float)width
            progress:(UploadProgress)progress
             success:(NetworkSuccess)successBlock
             failure:(NetworkFailure)failureBlock;

#pragma mark --- 文件下载
+ (void)DownloadFileWithSavePath:(NSString *)savePath
                         hosturl:(NSString *)hosturl
                          result:(NetworkResult)resultBlock
                        progress:(DownloadProgress)progress;

#pragma mark --- 取消所有request
+ (void)CancelAllRequest;

#pragma mark --- 取消指定的url请求/
+ (void)cancelHttpRequestWithRequestType:(NSString *)requestType requestUrlString:(NSString *)string;

@end
