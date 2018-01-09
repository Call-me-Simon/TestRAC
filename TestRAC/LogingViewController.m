//
//  LogingViewController.m
//  TestRAC
//
//  Created by Simon on 2017/12/26.
//  Copyright © 2017年 Simon. All rights reserved.
//

#import "LogingViewController.h"
#import "LogingViewModel.h"
#import <ReactiveObjC.h>

@interface LogingViewController ()
@property (nonatomic, strong) LogingViewModel *loginViewModel;
@property (weak, nonatomic) IBOutlet UITextField *nameTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@property (weak, nonatomic) IBOutlet UIButton *logingBtn;
@property (weak, nonatomic) IBOutlet UIButton *btn1;
@property (weak, nonatomic) IBOutlet UIButton *btn2;
@end

@implementation LogingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self testRac];
    [self bindModel];
    // Do any additional setup after loading the view from its nib.
}

-(void)testRac
{
    //    NSArray *array = @[@"1",@"2",@"3",@"4",@"5"];
    //    [array.rac_sequence.signal subscribeNext:^(id  _Nullable x) {
    //        NSLog(@"%@",x);
    //    }];
    
    //    NSArray *newArray = [[array.rac_sequence map:^NSString*(NSString *value) {
    //        return [value integerValue] > 3 ? value : nil;
    //    }] array];
    
    //    NSDictionary *dictionary = @{@"key1":@"value1", @"key2":@"value2", @"key3":@"value3"};
    //    [dictionary.rac_sequence.signal subscribeNext:^(RACTuple*  _Nullable x) {
    //        RACTupleUnpack(NSString *key, NSString *value) = x;
    //        NSLog(@"键%@-->值%@",key,value);
    //    }];
    
    //    UITextField *textField = [[UITextField alloc] init];
    //    [[textField.rac_textSignal filter:^BOOL(NSString *value) {
    //        return value.length > 5;
    //    }] subscribeNext:^(NSString * _Nullable x) {
    //        NSLog(@"%@",x);
    //    }];
    
    //    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    //    [[btn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
    //
    //    }];
    
//    [[[NSNotificationCenter defaultCenter] rac_addObserverForName:UIKeyboardWillShowNotification object:nil] subscribeNext:^(NSNotification * _Nullable x) {
//        NSLog(@"%@ 键盘弹起", x); // x 是通知对象
//    }];
}

// 视图模型绑定
- (void)bindModel
{
    RAC(self.logingBtn,enabled) = [RACSignal combineLatest:@[self.nameTextField.rac_textSignal,self.passwordTextField.rac_textSignal] reduce:^id _Nonnull(NSString *name,NSString *pwd){
        return @(name.length > 0 && pwd.length > 0);
    }];
    
//    RAC(self.loginViewModel.account, account) = _nameTextField.rac_textSignal;
//    RAC(self.loginViewModel.account, pwd) = _passwordTextField.rac_textSignal;
    
    //绑定登录按钮
//    RAC(self.logingBtn,enabled) = self.loginViewModel.enableLoginSignal;
    
    //监听登录按钮的点击
    [[self.logingBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        
        [self.loginViewModel.loginCommand execute:nil];
        
    }];
}

-(LogingViewModel *)loginViewModel
{
    if (!_loginViewModel) {
        _loginViewModel = [[LogingViewModel alloc] init];
    }
    
    return _loginViewModel;
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
