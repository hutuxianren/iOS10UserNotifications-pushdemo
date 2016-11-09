//
//  NotificationAction.m
//  ios10通知学习
//
//  Created by 涂逸欣 on 16/11/9.
//  Copyright © 2016年 涂逸欣. All rights reserved.
#pragma mark 注意事项
//1. UNNotificationActionOptions是一个枚举类型，是用来标识Action触发的行为方式分别是：
//需要解锁显示，点击不会进app。
//UNNotificationActionOptionAuthenticationRequired = (1 << 0),
//红色文字。点击不会进app。
//UNNotificationActionOptionDestructive = (1 << 1),
//黑色文字。点击会进app。
//UNNotificationActionOptionForeground = (1 << 2),

//2. UNNotificationAction是按钮action，UNTextInputNotificationAction是输入框Action

//3. 创建 UNTextInputNotificationAction 比 UNNotificationAction 多了两个参数
//buttonTitle 输入框右边的按钮标题
//placeholder 输入框占位符

#import "NotificationAction.h"
#import <UserNotifications/UserNotifications.h>
@implementation NotificationAction
+ (void)addNotificationAction{
    //创建按钮action
    UNNotificationAction * lookaction=[UNNotificationAction actionWithIdentifier:@"action.look" title:@"查看邀请" options:UNNotificationActionOptionAuthenticationRequired];
    UNNotificationAction * joinaction=[UNNotificationAction actionWithIdentifier:@"action.join" title:@"接受邀请" options:UNNotificationActionOptionForeground];
        UNNotificationAction * rejectaction=[UNNotificationAction actionWithIdentifier:@"action.reject" title:@"拒绝邀请" options:UNNotificationActionOptionDestructive];
    
    //注册category
    // * identifier 标识符
    // * actions 操作数组
    // * intentIdentifiers 意图标识符 可在 <Intents/INIntentIdentifiers.h> 中查看，主要是针对电话、carplay 等开放的 API。
    // * options 通知选项 枚举类型 也是为了支持 carplay
    UNNotificationCategory *notiCate=[UNNotificationCategory categoryWithIdentifier:@"make" actions:@[lookaction,joinaction,rejectaction] intentIdentifiers:@[] options:UNNotificationCategoryOptionCustomDismissAction];
    UNUserNotificationCenter *center=[UNUserNotificationCenter currentNotificationCenter];
    [center setNotificationCategories:[NSSet setWithObject:notiCate]];
    
    
}
@end
