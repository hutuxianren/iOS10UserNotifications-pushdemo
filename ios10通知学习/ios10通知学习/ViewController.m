//
//  ViewController.m
//  ios10通知学习
//
//  Created by 涂逸欣 on 16/10/27.
//  Copyright © 2016年 涂逸欣. All rights reserved.
//

#import "ViewController.h"
#import <UserNotifications/UserNotifications.h>
@interface ViewController ()
@property(nonatomic,strong)UIButton * localBtn;//本地推送,自带附件
@property(nonatomic,strong)UIButton * localCusBtn;//本地推送，自定义界面
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.localBtn=[[UIButton alloc]init];
    [self.localBtn addTarget:self action:@selector(localPush) forControlEvents:UIControlEventTouchDown];
    self.localBtn.frame=CGRectMake(100, 100, 200 , 100);
    [self.localBtn setTitle:@"本地推送" forState:UIControlStateNormal];
    self.localBtn.backgroundColor=[UIColor redColor];
    [self.view addSubview:self.localBtn];
    
    self.localCusBtn=[[UIButton alloc]init];
    [self.localCusBtn addTarget:self action:@selector(localCusPush) forControlEvents:UIControlEventTouchDown];
    self.localCusBtn.frame=CGRectMake(100, 250, 200 , 100);
    [self.localCusBtn setTitle:@"本地推送自定界面" forState:UIControlStateNormal];
    self.localCusBtn.backgroundColor=[UIColor redColor];
    [self.view addSubview:self.localCusBtn];
}
#pragma mark 本地推送,自带附件
- (void)localPush
{
    // 设置触发条件 UNNotificationTrigger
    UNTimeIntervalNotificationTrigger *timeTrigger = [UNTimeIntervalNotificationTrigger triggerWithTimeInterval:1.0f repeats:NO];
    UNMutableNotificationContent *content=[[UNMutableNotificationContent alloc]init];
    content.title=@"标题";
    content.subtitle=@"副标题";
    content.body=@"推送内容";
    content.badge=@123;
    content.sound=[UNNotificationSound defaultSound];
    content.userInfo=@{@"key":@"value"};
    content.categoryIdentifier=@"mycategory";
    
    //附件可以使用音乐，视频和照片，使用自带界面时附件只能同时用一个，默认使用第一个附件。
    //①照片附件 10M以下
    NSString *imgURL = [[NSBundle mainBundle] pathForResource:@"like" ofType:@"jpg"];
    UNNotificationAttachment * attachment1 = [UNNotificationAttachment attachmentWithIdentifier:@"photo" URL:[NSURL fileURLWithPath:imgURL] options:nil error:nil];
    //②视频附件 50M以下
    NSString *videoURL = [[NSBundle mainBundle] pathForResource:@"hehe" ofType:@"mp4"];
    UNNotificationAttachment * attachment2 = [UNNotificationAttachment attachmentWithIdentifier:@"video" URL:[NSURL fileURLWithPath:videoURL] options:nil error:nil];
    //③音乐附件 5M以下
    NSString *mp3URL = [[NSBundle mainBundle] pathForResource:@"tougong" ofType:@"mp3"];
    UNNotificationAttachment * attachment3 = [UNNotificationAttachment attachmentWithIdentifier:@"mp3" URL:[NSURL fileURLWithPath:mp3URL] options:nil error:nil];
    content.attachments=@[attachment2,attachment1,attachment3];
    
    // 创建通知标示
    NSString *requestIdentifier = @"hutuxianren";
    // 创建通知请求 UNNotificationRequest 将触发条件和通知内容添加到请求中
    UNNotificationRequest *request = [UNNotificationRequest requestWithIdentifier:requestIdentifier content:content trigger:timeTrigger];
    UNUserNotificationCenter* center = [UNUserNotificationCenter currentNotificationCenter];
    [center addNotificationRequest:request withCompletionHandler:^(NSError * _Nullable error) {
        if (!error) {
            NSLog(@"推送已添加成功 %@", requestIdentifier);
            //你自己的需求例如下面：
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"本地通知" message:@"成功添加推送" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
            [alert addAction:cancelAction];
            [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:alert animated:YES completion:nil];
            //此处省略一万行需求。。。。
        }
    }];
}

- (void)localCusPush
{
    UNTimeIntervalNotificationTrigger *timeTrigger = [UNTimeIntervalNotificationTrigger triggerWithTimeInterval:1.0f repeats:NO];
    UNMutableNotificationContent *content=[[UNMutableNotificationContent alloc]init];
    content.title=@"标题";
    content.subtitle=@"副标题";
    content.body=@"自定义界面";
    content.badge=@123;
    content.sound=[UNNotificationSound defaultSound];
    content.userInfo=@{@"key":@"value"};
    content.categoryIdentifier=@"mycategory";
    
    NSString *imgURL = [[NSBundle mainBundle] pathForResource:@"like" ofType:@"jpg"];
    UNNotificationAttachment * attachment1 = [UNNotificationAttachment attachmentWithIdentifier:@"photo" URL:[NSURL fileURLWithPath:imgURL] options:nil error:nil];
    content.attachments=@[attachment1];
    // 创建通知标示
    NSString *requestIdentifier = @"testCus";
    // 创建通知请求 UNNotificationRequest 将触发条件和通知内容添加到请求中
    UNNotificationRequest *request = [UNNotificationRequest requestWithIdentifier:requestIdentifier content:content trigger:timeTrigger];
    UNUserNotificationCenter* center = [UNUserNotificationCenter currentNotificationCenter];
    [center addNotificationRequest:request withCompletionHandler:^(NSError * _Nullable error) {
        if (!error) {
            NSLog(@"推送已添加成功 %@", requestIdentifier);
            //你自己的需求例如下面：
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"本地通知" message:@"成功添加推送" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
            [alert addAction:cancelAction];
            [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:alert animated:YES completion:nil];
            //此处省略一万行需求。。。。
        }
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
