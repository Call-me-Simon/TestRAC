//
//  LogingViewModel.h
//  TestRAC
//
//  Created by Simon on 2017/12/26.
//  Copyright © 2017年 Simon. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Account;
@interface LogingViewModel : NSObject

@property (nonatomic, strong) Account *account;

//@property (nonatomic, strong, readonly) RACSignal *enableLoginSignal;

@property (nonatomic, strong, readonly) RACCommand *loginCommand;

@end

@interface Account : NSObject

@property (nonatomic, copy) NSString *account;

@property (nonatomic, copy) NSString *pwd;

@property (nonatomic, copy) NSString *phone;

@property (nonatomic, copy) NSString *userid;

@property (nonatomic, copy) NSString *icon;

@end
