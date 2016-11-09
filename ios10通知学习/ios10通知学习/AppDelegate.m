//
//  AppDelegate.m
//  ios10通知学习
//
//  Created by 涂逸欣 on 16/10/27.
//  Copyright © 2016年 涂逸欣. All rights reserved.
//

#import "AppDelegate.h"
//这种写法防止低版本找不到头文件出现问题
#ifdef NSFoundationVersionNumber_iOS_9_x_Max
#import <UserNotifications/UserNotifications.h>
#endif
#import "NotificationAction.h"


#define IOS10_OR_LATER ([[[UIDevice currentDevice] systemVersion] floatValue] >= 10.0)
#define IOS9_OR_LATER ([[[UIDevice currentDevice] systemVersion] floatValue] >= 9.0)
#define IOS8_OR_LATER ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)
#define IOS7_OR_LATER ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0)

@interface AppDelegate ()<UNUserNotificationCenterDelegate>

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    [self replyPushNotificationAuthorization:application];//申请通知权限
    return YES;
}

#pragma mark - 申请通知权限
// 申请通知权限
- (void)replyPushNotificationAuthorization:(UIApplication *)application{
    
    if (IOS10_OR_LATER) {
        //iOS 10 later
        UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
        //必须写代理，不然无法监听通知的接收与点击事件
        center.delegate = self;
        [center requestAuthorizationWithOptions:(UNAuthorizationOptionBadge | UNAuthorizationOptionSound | UNAuthorizationOptionAlert) completionHandler:^(BOOL granted, NSError * _Nullable error) {
            if (!error && granted) {
                //用户点击允许
                NSLog(@"注册成功");
            }else{
                //用户点击不允许
                NSLog(@"注册失败");
            }
        }];
        
        // 可以通过 getNotificationSettingsWithCompletionHandler 获取权限设置
        //之前注册推送服务，用户点击了同意还是不同意，以及用户之后又做了怎样的更改我们都无从得知，现在 apple 开放了这个 API，我们可以直接获取到用户的设定信息了。注意UNNotificationSettings是只读对象哦，不能直接修改！
        [center getNotificationSettingsWithCompletionHandler:^(UNNotificationSettings * _Nonnull settings) {
            NSLog(@"========%@",settings);
        }];
    }else if (IOS8_OR_LATER){
        //iOS 8 - iOS 10系统
        UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeAlert | UIUserNotificationTypeBadge | UIUserNotificationTypeSound categories:nil];
        [application registerUserNotificationSettings:settings];
    }else{
        //iOS 8.0系统以下
        [application registerForRemoteNotificationTypes:UIRemoteNotificationTypeBadge | UIRemoteNotificationTypeAlert | UIRemoteNotificationTypeSound];
    }
    [NotificationAction addNotificationAction];
    //注册远端消息通知获取device token,远端推送需要获取设备的Device Token的方法是没有变的
    //[application registerForRemoteNotifications];
}

#pragma mark - iOS10 收到通知（本地和远端） UNUserNotificationCenterDelegate
//App处于前台接收通知时:下面这个代理方法，只会是app处于前台状态 前台状态 and 前台状态下才会走，后台模式下是不会走这里的
- (void)userNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(UNNotificationPresentationOptions))completionHandler
{
    UNNotificationRequest *request=notification.request;//接受请求
    UNNotificationContent *content=request.content;//内容
    NSDictionary *userInfo=content.userInfo;//基本信息
    NSNumber *badge=content.badge;//消息角标
    NSString *body=content.body;//消息主体
    UNNotificationSound *sound=content.sound;//推送声音
    NSString *title=content.title;
    NSString *subtitle=content.subtitle;
    NSLog(@"iOS10 收到本地通知:{\\\\nbody:%@，\\\\ntitle:%@,\\\\nsubtitle:%@,\\\\nbadge：%@，\\\\nsound：%@，\\\\nuserInfo：%@\\\\n}",body,title,subtitle,badge,sound,userInfo);
    completionHandler(UNNotificationPresentationOptionAlert|UNNotificationPresentationOptionBadge
                      |UNNotificationPresentationOptionSound);
}

//App通知的点击事件:下面这个代理方法，只会是用户点击消息才会触发，如果使用户长按（3DTouch）、弹出Action页面等并不会触发。点击Action的时候会触发！
- (void)userNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void (^)())completionHandler{
    //点击或输入action
    NSString* actionIdentifierStr = response.actionIdentifier;
    NSLog(@"actionID===%@",actionIdentifierStr);
    if ([response isKindOfClass:[UNTextInputNotificationResponse class]]) {
        NSString* userSayStr = [(UNTextInputNotificationResponse *)response userText];
        
        NSLog(@"actionid = %@\n  userSayStr = %@",actionIdentifierStr, userSayStr);
        //此处省略一万行需求代码。。。。
    }
    if ([actionIdentifierStr isEqualToString:@"action.look"]){
        
        //此处省略一万行需求代码
        NSLog(@"actionid = %@\n",actionIdentifierStr);
    }
    if ([actionIdentifierStr isEqualToString:@"action.join"]) {
        
        //此处省略一万行需求代码
        NSLog(@"actionid = %@\n",actionIdentifierStr);
    }

        completionHandler(); // 系统要求执行这个方法,点击代理最后需要执行：completionHandler(); 不然报错
}
- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
