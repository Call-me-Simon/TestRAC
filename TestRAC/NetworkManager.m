//
//  NetworkManager.m
//  TestRAC
//
//  Created by Simon on 2018/1/8.
//  Copyright © 2018年 Simon. All rights reserved.
//

#import "NetworkManager.h"
#import <AFNetworking.h>
#import "UIImage+CompressImage.h"

@implementation NetworkManager

+(AFHTTPSessionManager *)shareManager
{
    static AFHTTPSessionManager *manager = nil;
    static dispatch_once_t onceToken;
    __weak typeof(self) weakSelf = self;
    dispatch_once(&onceToken, ^{
        [manager setSecurityPolicy:[weakSelf initSecurityPolicy]];
        manager.responseSerializer = [AFHTTPResponseSerializer serializer];
        manager.requestSerializer = [AFHTTPRequestSerializer serializer];
        manager.reachabilityManager = [AFNetworkReachabilityManager manager];
    });
    
    return manager;
}

+ (NSURLSessionDataTask *)GET:(NSString *)hosturl parameters:(NSDictionary *)params success:(NetworkSuccess)success failure:(NetworkFailure)failure
{
    AFHTTPSessionManager *manager = [self shareManager];
    NSString *urlString = [NSString stringWithFormat:@"%@%@", N_HostSite, hosturl];
    
    return [manager GET:urlString parameters:params progress:nil success:success failure:failure];
}

+ (NSURLSessionDataTask *)POST:(NSString *)hosturl parameters:(NSDictionary *)params success:(NetworkSuccess)success failure:(NetworkFailure)failure
{
    NSMutableDictionary *paramsDic = (params?:@{}).mutableCopy;
    NSData *userData = [[NSUserDefaults standardUserDefaults] objectForKey:kUserInfoKey];
    
    if (userData.length > 0) {
        NSDictionary *userDic = [NSJSONSerialization JSONObjectWithData:userData options:0 error:nil];
        if (userDic) {
            NSString *tokenString = params[@"Token"];
            if (tokenString.length <= 0) {
                NSString *loginToken = userDic[@"Token"];
                paramsDic[@"Token"]= loginToken;
            }
            
//            NSString *memberCode = params[@"username"];
//            if (memberCode.length <= 0) {
//                NSString *usermemberCode = userDic[@"MemberCode"];
//                paramsDic[@"username"]= usermemberCode;
//            }
        }
    }
    AFHTTPSessionManager *manager = [self shareManager];
    NSString *urlString = [NSString stringWithFormat:@"%@%@", N_HostSite, hosturl];
    if ([hosturl hasPrefix:@"http"]) {
        urlString = hosturl;
    }
    
    __weak typeof (self) weakSelf = self;
    return [manager POST:urlString parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *userDic = [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:nil];
        if ([userDic[@"Status"] integerValue] == 40012) {
//            [[NSNotificationCenter defaultCenter] postNotificationName:kWSNetworkManageTokenUnuseNotification object:nil];
            [weakSelf CancelAllRequest];
            
            id rootVC = [UIApplication sharedApplication].delegate.window.rootViewController;
            if ([rootVC isKindOfClass:[UINavigationController class]]) {
                UINavigationController *loginNC = (UINavigationController *)rootVC;
//                if (![[loginNC.viewControllers firstObject] isKindOfClass:[WSHomePageVC class]]) {
//                    [weakSelf enterLoginHomePage];
//                } else {
//                    // 如果当前在登陆页，则不进行任何操作
//                }
            } else {
//                [weakSelf enterLoginHomePage];
            }
            NSLog(@"请求取消");
        } else {
            success(task, responseObject);
        }
        
    } failure:failure];
}

#pragma mark --- 图片上传
+ (void)UploadImages:(NSArray *)imageArray
             hosturl:(NSString *)hosturl
          parameters:(NSDictionary *)params
         targetWidth:(float)width
            progress:(UploadProgress)progress
             success:(NetworkSuccess)successBlock
             failure:(NetworkFailure)failureBlock
{
    AFHTTPSessionManager *manager = [self shareManager];
    [manager POST:hosturl parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        NSUInteger i = 0 ;
        /**出于性能考虑,将上传图片进行压缩*/
        for (UIImage * image in imageArray) {
            //image的分类方法
            UIImage *  resizedImage =  [UIImage IMGCompressed:image targetWidth:width];
            NSData * imgData = UIImageJPEGRepresentation(resizedImage, .5);
            //拼接data
            [formData appendPartWithFileData:imgData name:[NSString stringWithFormat:@"picflie%ld",(long)i] fileName:@"image.png" mimeType:@" image/jpeg"];
            i++;
        }
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        progress(uploadProgress.completedUnitCount / uploadProgress.totalUnitCount);
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        successBlock(task,responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failureBlock(task,error);
    }];
}

#pragma mark --- 文件下载
+ (void)DownloadFileWithSavePath:(NSString *)savePath
                         hosturl:(NSString *)hosturl
                          result:(NetworkResult)resultBlock
                        progress:(DownloadProgress)progress
{
    AFHTTPSessionManager *manager = [self shareManager];
    
    [manager downloadTaskWithRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:hosturl]] progress:^(NSProgress * _Nonnull downloadProgress) {
        progress(downloadProgress.completedUnitCount / downloadProgress.totalUnitCount);
    } destination:^NSURL * _Nonnull(NSURL * _Nonnull targetPath, NSURLResponse * _Nonnull response) {
        return [NSURL URLWithString:savePath];
    } completionHandler:^(NSURLResponse * _Nonnull response, NSURL * _Nullable filePath, NSError * _Nullable error) {
        resultBlock(filePath,error);
    }];
}

#pragma mark --- 取消所有request
+ (void)CancelAllRequest
{
    [[self shareManager].operationQueue cancelAllOperations];
}

#pragma mark --- 取消指定的url请求/
+ (void)cancelHttpRequestWithRequestType:(NSString *)requestType requestUrlString:(NSString *)string
{
    NSError * error;
    /**根据请求的类型 以及 请求的url创建一个NSMutableURLRequest---通过该url去匹配请求队列中是否有该url,如果有的话 那么就取消该请求*/
    NSString * urlToBeCanced = [[[[AFHTTPSessionManager manager].requestSerializer requestWithMethod:requestType URLString:string parameters:nil error:&error] URL] path];
    for (NSOperation * operation in [AFHTTPSessionManager manager].operationQueue.operations) {
        //如果是请求队列
        if ([operation isKindOfClass:[NSURLSessionTask class]]) {
            //请求的类型匹配
            BOOL hasMatchRequestType = [requestType isEqualToString:[[(NSURLSessionTask *)operation currentRequest] HTTPMethod]];
            //请求的url匹配
            BOOL hasMatchRequestUrlString = [urlToBeCanced isEqualToString:[[[(NSURLSessionTask *)operation currentRequest] URL] path]];
            //两项都匹配的话  取消该请求
            if (hasMatchRequestType&&hasMatchRequestUrlString) {
                [operation cancel];
            }
        }
    }
}

#pragma mark --- security
+(AFSecurityPolicy *)initSecurityPolicy
{
//    // /先导入证书
//    NSString *cerPath = [[NSBundle mainBundle] pathForResource:@"avantouch" ofType:@"cer"];//证书的路径
//    NSData *certData = [NSData dataWithContentsOfFile:cerPath];
//
//    // AFSSLPinningModeCertificate 使用证书验证模式
//    AFSecurityPolicy *securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeCertificate];
//    securityPolicy.pinnedCertificates = [NSSet setWithObjects:certData, nil];

    AFSecurityPolicy *securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
    
    // allowInvalidCertificates 是否允许无效证书（也就是自建的证书），默认为NO
    // 如果是需要验证自建证书，需要设置为YES
    securityPolicy.allowInvalidCertificates = YES;
    
    //validatesDomainName 是否需要验证域名，默认为YES；
    //假如证书的域名与你请求的域名不一致，需把该项设置为NO；如设成NO的话，即服务器使用其他可信任机构颁发的证书，也可以建立连接，这个非常危险，建议打开。
    //置为NO，主要用于这种情况：客户端请求的是子域名，而证书上的是另外一个域名。因为SSL证书上的域名是独立的，假如证书上注册的域名是www.google.com，那么mail.google.com是无法验证通过的；当然，有钱可以注册通配符的域名*.google.com，但这个还是比较贵的。
    //如置为NO，建议自己添加对应域名的校验逻辑。
    securityPolicy.validatesDomainName = NO;
    
    return securityPolicy;
}
@end
