//
//  ViewController.m
//  TestRAC
//
//  Created by Simon on 2016/11/25.
//  Copyright © 2016年 Simon. All rights reserved.
//

#import "ViewController.h"
#import <ReactiveObjC/RACReturnSignal.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    [self createRACSignal];
//    [self createRACSubject];
//    [self concat];
//    [self then];
//    [self merge];
//    [self zipWith];
//    [self combineLatest];
//    [self reduce];
    [self doNextdoCompleted];
//    [self timeout];
//    [self interval];
    
    // Do any additional setup after loading the view, typically from a nib.
}

-(void)delay
{
    NSArray *nums = @[@1,@2,@3,@4];
    [nums.rac_sequence.signal subscribeNext:^(id  _Nullable x) {
        
    }];
}

-(void)interval
{
    [[RACSignal interval:1.0f onScheduler:[RACScheduler currentScheduler]] subscribeNext:^(id  _Nullable x) {
        
        NSLog(@"%@",x);
        
    }];
}

-(void)timeout
{
    RACSignal *signal = [[RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
//        [subscriber sendNext:@1];
        return nil;
    }] timeout:1.0f onScheduler:[RACScheduler scheduler]];
    
    [signal subscribeNext:^(id  _Nullable x) {
        NSLog(@"%@",x);
    } error:^(NSError * _Nullable error) {
       //1秒后会自动调用
        NSLog(@"%@",error.localizedDescription);
    }];
}

-(void)doNextdoCompleted
{
//    [[[[RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
//
//        [subscriber sendNext:@10];
//
//        [subscriber sendCompleted];
//
//        return nil;
//
//    }] doNext:^(id  _Nullable x) {
//        //执行[subscriber sendNext:@10]之前会调用
//        NSLog(@"doNext");
//    }] doCompleted:^{
//        // 执行[subscriber sendCompleted];之前会调用这个Block
//        NSLog(@"doCompleted");
//    }] subscribeNext:^(id  _Nullable x) {
//        NSLog(@"%@",x);
//    }];
    
//    RACSubject *subject = [RACSubject subject];
//    [[subject take:1] subscribeNext:^(id  _Nullable x) {
//        NSLog(@"%@",x);
//    }];
//    [subject sendNext:@1];
//    [subject sendNext:@2];

//    RACSubject *signal = [RACSubject subject];
//    [[signal takeLast:1] subscribeNext:^(id  _Nullable x) {
//        NSLog(@"%@",x);
//    }];
//    [signal sendNext:@1];
//    [signal sendNext:@2];
//    [signal sendCompleted];

//    RACSubject *signalofsignals = [RACSubject subject];
//    RACSubject *signal = [RACSubject subject];
//    [signalofsignals.switchToLatest subscribeNext:^(id  _Nullable x) {
//        NSLog(@"%@",x);
//    }];
//    [signalofsignals sendNext:signal];
//    [signal sendNext:@1];
    
//    [[[[RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
//        [subscriber sendNext:@1];
//        [subscriber sendCompleted];
//        return nil;
//    }] doNext:^(id  _Nullable x) {
//         // 执行[subscriber sendNext:@1];之前会调用这个Block
//         NSLog(@"doNext");
//    }] doCompleted:^{
//         // 执行[subscriber sendCompleted];之前会调用这个Block
//         NSLog(@"doCompleted");
//    }] subscribeNext:^(id  _Nullable x) {
//        NSLog(@"%@",x);
//    }];
    
    RACSignal *signal = [[RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
        [subscriber sendNext:@1];
        [subscriber sendNext:@2];
        return nil;
    }] replay];
    
    [signal subscribeNext:^(id  _Nullable x) {
        NSLog(@"第一个订阅者%@",x);
    }];
    
    [signal subscribeNext:^(id  _Nullable x) {
        NSLog(@"第二个订阅者%@",x);
    }];
    
//    __block int i = 0;
//    [[[RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
//        if (i == 10) {
//            [subscriber sendNext:@1];
//        }else{
//            NSLog(@"接受错误%d",i);
//            [subscriber sendError:nil];
//        }
//        i++;
//
//        return nil;
//    }] retry] subscribeNext:^(id  _Nullable x) {
//        NSLog(@"%@",x);
//    } error:^(NSError * _Nullable error) {
//        NSLog(@"%@",error);
//    }];
    
    
//    [[RACSignal interval:1 onScheduler:[RACScheduler currentScheduler]] subscribeNext:^(id  _Nullable x) {
//        NSLog(@"%@",x);
//    }];
    
//    [[[RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
//        [subscriber sendNext:@1];
//        return nil;
//    }] timeout:2 onScheduler:[RACScheduler currentScheduler]]subscribeNext:^(id  _Nullable x) {
//            NSLog(@"%@",x);
//    } error:^(NSError * _Nullable error) {
//        // 1秒后会自动调用
//        NSLog(@"%@",error);
//    }];
    
//    UITextField *textfield = [UITextField new];
    
//    [[textfield.rac_textSignal skip:2] subscribeNext:^(NSString * _Nullable x) {
//        NSLog(@"%@",x);
//    }];
    
//    [textfield.rac_textSignal takeUntil:self.rac_willDeallocSignal];
    
//    [textfield.rac_textSignal filter:^BOOL(NSString *value) {
//        return value.length > 3;
//    }];
    
//    [[textfield.rac_textSignal ignore:@"1"] subscribeNext:^(NSString * _Nullable x) {
//        NSLog(@"%@",x);
//    }];
    
//    [[textfield.rac_textSignal distinctUntilChanged] subscribeNext:^(NSString * _Nullable x) {
//        NSLog(@"%@",x);
//    }];
    
//    [[textfield.rac_textSignal flattenMap:^RACStream *(id value) {
//        return [RACReturnSignal return:[NSString stringWithFormat:@"转换:%@",value]];
//    }] subscribeNext:^(NSString * _Nullable x) {
//
//    }];
    
//    RACSignal *signal1 = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
//        [subscriber sendNext:@1];
//        return nil;
//    }];
    
//    RACSignal *signal2 = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
//        [subscriber sendNext:@3];
//        return nil;
//    }];
    
//    RACSignal *zipSignal = [signal1 zipWith:signal2];
//    [zipSignal subscribeNext:^(id  _Nullable x) {
//        NSLog(@"%@",x);
//    }];
    // 底层实现:
    // 1.定义压缩信号，内部就会自动订阅signalA，signalB
    // 2.每当signalA或者signalB发出信号，就会判断signalA，signalB有没有发出个信号，有就会把最近发出的信号都包装成元组发出。
//    RACSignal *signalA = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
//        [subscriber sendNext:@1];
//        return nil;
//    }];
//
//    RACSignal *signalB = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
//        [subscriber sendNext:@2];
//        return nil;
//    }];
//
//    RACSignal *reduceSignal = [RACSignal combineLatest:@[signalA,signalB] reduce:^id(NSNumber *numA,NSNumber *numB){
//
//        return [NSString stringWithFormat:@"%@%@",numA,numB];
//    }];
//
//    [reduceSignal subscribeNext:^(id  _Nullable x) {
//        NSLog(@"%@",x);
//    }];
}

-(void)reduce
{
    RACSignal *signalA = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
        
        [subscriber sendNext:@2];
        
        return nil;
    }];
    
    RACSignal *signalB = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
        
        [subscriber sendNext:@10];
        
        return nil;
        
    }];
    
    RACSignal *reduceSignal = [RACSignal combineLatest:@[signalA,signalB] reduce:^id (NSNumber *num1,NSNumber *num2){
        
        return [NSString stringWithFormat:@"%@%@",num1,num2];
        
    }];
    
    [reduceSignal subscribeNext:^(id  _Nullable x) {
       
        NSLog(@"%@",x);
        
    }];
}

-(void)combineLatest
{
    RACSignal *signalA = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
       
        [subscriber sendNext:@2];
        
        return nil;
    }];
    
    RACSignal *signalB = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
       
        [subscriber sendNext:@10];
        
        return nil;
        
    }];
    
    RACSignal *combineLatestSignal = [signalA combineLatestWith:signalB];
    
    [combineLatestSignal subscribeNext:^(id  _Nullable x) {
       
        NSLog(@"%@",x);
        
    }];
}

-(void)zipWith
{
    RACSignal *signalA = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
        
        [subscriber sendNext:@1];
        
        return nil;
    }];
    
    RACSignal *signalB = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
        
        [subscriber sendNext:@2];
        
        return nil;
        
    }];
    
    RACSignal *zipWithSignal = [signalA zipWith:signalB];
    
    [zipWithSignal subscribeNext:^(id  _Nullable x) {
        
        NSLog(@"%@",x);
        
    }];
}

-(void)merge
{
    RACSignal *signalA = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
        
        [subscriber sendNext:@1];
        
        return nil;
    }];
    
    RACSignal *signalB = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
        
        [subscriber sendNext:@2];
        
        return nil;
        
    }];
    
    RACSignal *mergeSignal = [signalA merge:signalB];
    
    [mergeSignal subscribeNext:^(id  _Nullable x) {
        NSLog(@"%@",x);
    }];
}

-(void)then
{
    [[[RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
        
        [subscriber sendNext:@1];
        [subscriber sendCompleted];
        return nil;
    }] then:^RACSignal * _Nonnull{
        return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
            [subscriber sendNext:@2];
            return nil;
        }];
    }] subscribeNext:^(id  _Nullable x) {
        
        NSLog(@"%@",x);
        
    }];
}

-(void)concat
{
    RACSignal *signalA = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
        
        [subscriber sendNext:@1];
        [subscriber sendCompleted];
        
        return nil;
    }];
    
    RACSignal *signalB = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
        
        [subscriber sendNext:@2];
        
        return nil;
    }];
    
    RACSignal *concatSignal = [signalA concat:signalB];
    
    [concatSignal subscribeNext:^(id  _Nullable x) {
        NSLog(@"%@",x);
    }];
}

//RACSiganl简单使用:
-(void)createRACSignal
{
    RACSignal *signal = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
        
        //block调用时刻；每当有订阅者订阅信号，就会调用block
        
        //2/发送信号
        [subscriber sendNext:@1];
        
        //如果没有发送数据，最好发送信号完成，内部自动调用[RACDisposable disposable]取消订阅信号。
        [subscriber sendCompleted];
        
        return [RACDisposable disposableWithBlock:^{
            
            //block调用时刻：当信号发送完成或者发送错误，就会自动执行这个block，取消订阅信号。
            
            //执行完block后，当前信号就不在被订阅了。
            
            NSLog(@"信号被销毁");
            
        }];
    }];
    
    //3.订阅信号，才会激活信号
    [signal subscribeNext:^(id  _Nullable x) {
        //block调用时刻：每当有信号发出数据，就会调用block
        NSLog(@"接受到的数据%@",x);
    }];
}

//RACSubject和RACReplaySubject简单使用:
-(void)createRACSubject
{
    // RACSubject使用步骤
    // 1.创建信号 [RACSubject subject]，跟RACSiganl不一样，创建信号时没有block。
    // 2.订阅信号 - (RACDisposable *)subscribeNext:(void (^)(id x))nextBlock
    // 3.发送信号 sendNext:(id)value
    
    // RACSubject:底层实现和RACSignal不一样。
    // 1.调用subscribeNext订阅信号，只是把订阅者保存起来，并且订阅者的nextBlock已经赋值了。
    // 2.调用sendNext发送信号，遍历刚刚保存的所有订阅者，一个一个调用订阅者的nextBlock。

    //1.创建信号
    RACSubject *subject = [RACSubject subject];
    
    //2.订阅信号
    [subject subscribeNext:^(id x) {
        // block调用时刻：当信号发出新值，就会调用.
        NSLog(@"第一个订阅者%@",x);
    }];
    [subject subscribeNext:^(id x) {
        // block调用时刻：当信号发出新值，就会调用.
        NSLog(@"第二个订阅者%@",x);
    }];
    
    // 3.发送信号
    [subject sendNext:@"1"];
    
    // RACReplaySubject使用步骤:
    // 1.创建信号 [RACSubject subject]，跟RACSiganl不一样，创建信号时没有block。
    // 2.可以先订阅信号，也可以先发送信号。
    // 2.1 订阅信号 - (RACDisposable *)subscribeNext:(void (^)(id x))nextBlock
    // 2.2 发送信号 sendNext:(id)value
    
    // RACReplaySubject:底层实现和RACSubject不一样。
    // 1.调用sendNext发送信号，把值保存起来，然后遍历刚刚保存的所有订阅者，一个一个调用订阅者的nextBlock。
    // 2.调用subscribeNext订阅信号，遍历保存的所有值，一个一个调用订阅者的nextBlock
    
    // 如果想当一个信号被订阅，就重复播放之前所有值，需要先发送信号，在订阅信号。
    // 也就是先保存值，在订阅值。
    
    // 1.创建信号
    RACReplaySubject *replaySubject = [RACReplaySubject subject];
    
    //2.发送信号
    [replaySubject sendNext:@1];
    [replaySubject sendNext:@2];
    
    //3.订阅信号
    [replaySubject subscribeNext:^(id  _Nullable x) {
        NSLog(@"第一个订阅者接收到的数据%@",x);
    }];
    
    // 订阅信号
    [replaySubject subscribeNext:^(id x) {
        
        NSLog(@"第二个订阅者接收到的数据%@",x);
    }];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
