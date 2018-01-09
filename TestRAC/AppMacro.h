//
//  AppMacro.h
//  SuGuoMarketSurvey
//
//  Created by Simon on 16/2/20.
//  Copyright © 2016年 Simon. All rights reserved.
//

#ifndef AppMacro_h
#define AppMacro_h

#define mDocumentDir   [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject]
#define mCacheDir      [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject]
#define mTmpDir        NSTemporaryDirectory()
#define mHomeDir       NSHomeDirectory()

//----------方法简写-------
#define mWindow             [[[UIApplication sharedApplication] windows] lastObject]
#define mKeyWindow          [[UIApplication sharedApplication] keyWindow]
#define mDelegateWindow     [[[UIApplication sharedApplication] delegate] window]
#define mUserDefaults       [NSUserDefaults standardUserDefaults]
#define mNotificationCenter [NSNotificationCenter defaultCenter]
#define mFont(size)         [UIFont systemFontOfSize:size]
#define mB_Font(size)       [UIFont boldSystemFontOfSize:size]
//id对象与NSData之间转换

#define mObjectToData(object)   [NSKeyedArchiver archivedDataWithRootObject:object]
#define mDataToObject(data)     [NSKeyedUnarchiver unarchiveObjectWithData:data]
//度弧度转换

#define mDegreesToRadian(x)      (M_PI * (x) / 180.0)
#define mRadianToDegrees(radian) (radian*180.0) / (M_PI)
//颜色转换

#define mRGB(r, g, b)     [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1.0]
#define mRGBA(r, g, b, a) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a]

//rgb颜色转换（16进制->10进制）
#define mHexColor(hex) [UIColor colorWithRed:((float)((hex & 0xFF0000) >> 16))/255.0 green:((float)((hex & 0xFF00) >> 8))/255.0 blue:((float)(hex & 0xFF))/255.0 alpha:1.0]

//G－C－D
#define mGCDBackground(block) dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), block)
#define mGCDMain(block)       dispatch_async(dispatch_get_main_queue(),block)
#define mGCDAfter(sec, block) dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(sec * NSEC_PER_SEC)), dispatch_get_main_queue(), block)

//简单的以AlertView显示提示信息
#define mAlertView(title, msg) \
UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:title message:msg delegate:nil \
cancelButtonTitle:@"确定" \
otherButtonTitles:nil]; \
[alertView show];

//简单的以AlertController显示提示信息
#define mAlertController(title, msg, currentVC) \
UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:msg preferredStyle:UIAlertControllerStyleAlert];\
[alertController addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {\
}]];\
[currentVC presentViewController:alertController animated:YES completion:nil];\


//----------设备系统相关---------
#define mIsiP4     ([UIScreen mainScreen].bounds.size.height == 480.0)
#define mIsiP5     ([UIScreen mainScreen].bounds.size.height == 568.0)
#define mIsiP6     ([UIScreen mainScreen].bounds.size.height == 667.0)
#define mIsiP6P    ([UIScreen mainScreen].bounds.size.height == 736.0)
#define mIsiPad     [[UIDevice currentDevice].model containString:@"iPad"]
#define mIsiPhone   (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
#define mIsiOS8     [[[UIDevice currentDevice] systemVersion] integerValue] == 8
#define mIsiOS7     [[[UIDevice currentDevice] systemVersion] integerValue] == 7
#define mIsiOS6     [[[UIDevice currentDevice] systemVersion] integerValue] == 6
#define mLanguage   [[NSUserDefaults standardUserDefaults] objectForKey:@"AppleLanguages"][0]
#define mSystemVersion   ([[UIDevice currentDevice] systemVersion])
#define mCurrentLanguage ([[NSLocale preferredLanguages] objectAtIndex:0])
#define mAPPVersion      [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]
//----------页面设计相关-------
#define mNavBarHeight         44
#define mTabBarHeight         49
#define mScreenBounds         ([UIScreen mainScreen].bounds)
#define mScreenWidth          ([UIScreen mainScreen].bounds.size.width)
#define mScreenHeight         ([UIScreen mainScreen].bounds.size.height)
#define mMaxScreen            (MAX(mScreenWidth, mScreenHeight))//横竖屏切换
#define mMinScreen            (MIN(mScreenWidth, mScreenHeight))

#define mStatusBarHeight      ([UIApplication sharedApplication].statusBarFrame.size.height)
#define mNavHeight            (mNavBarHeight + mStatusBarHeight)
#define m6PScale              (mScreenWidth/1242.0)
#define m6Scale               (mScreenWidth/750.0)
#define m5Scale               (mScreenWidth/640.0)
#define k6Scale               (mScreenWidth/375.0)

//调试模式下输入NSLog，发布后不再输入。
#ifdef DEBUG
#define NSLog(...) NSLog(@"%s 第%d行 \n %@\n\n",__func__,__LINE__,[NSString stringWithFormat:__VA_ARGS__])
#else
#define NSLog(...)
#endif

// block self
#define mWeakSelf  __weak typeof (self)weakSelf = self;
#define mStrongSelf typeof(weakSelf) __strong strongSelf = weakSelf;

#endif /* AppMacro_h */


//-----------获得用户信息--------
#define USERINFO \
NSData *data = [[NSUserDefaults standardUserDefaults]objectForKey:kUserInfoKey]; \
NSDictionary *userinfo; \
if(data){ \
    userinfo = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];\
}else{\
    data = nil; \
    NSLog(@"用户的Data为空");\
}
#define kUserDefault      [NSUserDefaults standardUserDefaults]

