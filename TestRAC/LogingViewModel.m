//
//  LogingViewModel.m
//  TestRAC
//
//  Created by Simon on 2017/12/26.
//  Copyright © 2017年 Simon. All rights reserved.
//

#import "LogingViewModel.h"
#import <MBProgressHUD.h>

@interface LogingViewModel ()
@end

@implementation LogingViewModel

-(instancetype)init
{
    if (self = [super init]) {
        [self initialBind];
    }
    return self;
}

-(Account *)account
{
    if (!_account) {
        _account = [[Account alloc] init];
    }
    return _account;
}

// 初始化绑定
- (void)initialBind
{
    // 监听账号、密码的属性值改变，把他们聚合成一个信号。
//    _enableLoginSignal = [RACSignal combineLatest:@[RACObserve(self.account, account),RACObserve(self.account, pwd)] reduce:^id (NSString *account,NSString *pwd){
//        return @(account.length && pwd.length);
//    }];
    
    _loginCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal * (id input) {
        NSLog(@"点击了登录");
        
        return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
           
            //模拟网络延迟
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
               
                [subscriber sendNext:@"登陆成功"];
                // 数据传送完毕，必须调用完成，否则命令永远处于执行状态
                [subscriber sendCompleted];
            });
            
            return nil;
        }];
    }];
    
    //监听登录产生的数据
    [_loginCommand.executionSignals.switchToLatest subscribeNext:^(id  _Nullable x) {
        if ([x isEqualToString:@"登陆成功"]) {
            NSLog(@"登录成功");
        }
    }];
    
    //监听登录状态
    [[_loginCommand.executing skip:1] subscribeNext:^(NSNumber * _Nullable x) {
       
        if ([x isEqual:@(YES)]) {
            // 正在登录ing...
            MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:[UIApplication sharedApplication].keyWindow animated:YES];
            hud.mode = MBProgressHUDModeDeterminate;
            hud.label.text = @"正在登录";
        }else{
            //登陆成功
            [MBProgressHUD hideHUDForView:[UIApplication sharedApplication].keyWindow animated:YES];
        }
    }];
}




@end

@implementation Account

-(instancetype)init
{
    if (self = [super init]) {
        _account = @"348400564";
        _pwd = @"123456";
        _phone = @"15151648846";
        _icon = @"";
        _userid = @"12345";
    }
    return self;
}

@end

