//
//  AppConfig.h
//  TestRAC
//
//  Created by Simon on 2018/1/8.
//  Copyright © 2018年 Simon. All rights reserved.
//

#ifndef AppConfig_h
#define AppConfig_h

static NSString *const kAppId = @"1150234387";

#define kAppUrl     [NSString stringWithFormat:@"https://itunes.apple.com/us/app/ling-hao-xian/id%@?ls=1&mt=8", kAppId]
#define kRateUrl    [NSString stringWithFormat:@"itms-apps://ax.itunes.apple.com/WebObjects/MZStore.woa/wa/viewContentsUserReviews?type=Purple+Software&id=%@",kAppId]

/// 用户个人信息Key，使用NSUSerDefaults存取
static NSString *const kUserInfoKey         = @"kUserInfoKey";

#pragma mark- 网络请求主站点
#ifdef DEBUG
//测试环境主站点
#define N_HostSite  @""      //测试环境
#else
///正式环境主站点
#define N_HostSite  @""      //正式环境
#endif

#endif /* AppConfig_h */
