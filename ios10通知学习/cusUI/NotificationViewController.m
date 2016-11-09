//
//  NotificationViewController.m
//  cusUI
//
//  Created by 涂逸欣 on 16/11/9.
//  Copyright © 2016年 涂逸欣. All rights reserved.
//

#import "NotificationViewController.h"
#import <UserNotifications/UserNotifications.h>
#import <UserNotificationsUI/UserNotificationsUI.h>

@interface NotificationViewController () <UNNotificationContentExtension>

@property IBOutlet UILabel *label;
@property (strong, nonatomic) IBOutlet UIImageView *imageView;//自定义图片界面

@end

@implementation NotificationViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    // Do any required interface initialization here.
}

- (void)didReceiveNotification:(UNNotification *)notification {
    self.label.text = notification.request.content.body;
    //附件元素添加
    UNNotificationContent * content = notification.request.content;
    UNNotificationAttachment * attachment = content.attachments.firstObject;
    if (attachment.URL.startAccessingSecurityScopedResource) {
        self.imageView.image = [UIImage imageWithContentsOfFile:attachment.URL.path];
    }
}

@end
