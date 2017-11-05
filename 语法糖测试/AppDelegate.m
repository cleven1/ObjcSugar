//
//  AppDelegate.m
//  语法糖测试
//
//  Created by tusm on 2016/10/26.
//  Copyright © 2016年 cleven. All rights reserved.
//

#import "AppDelegate.h"
#import "LocalPushCenter.h"
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    //注册推送
    [LocalPushCenter registerLocalNotificationInAppDelegate];
    
    
    return YES;
}
#pragma mark - 收到推送
- (void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification{
    //点击推送进入
    NSLog(@"%@",notification);
    
    
    //在应用类接收到推送
    if (application.applicationState == UIApplicationStateActive) {
        
        NSString *content = [notification.userInfo objectForKey:@"content"];
        
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"本地推送" message:content preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *alertAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            
        }];
        [alertController addAction:alertAction];
        
        [self.window.rootViewController presentViewController:alertController animated:YES completion:nil];
        
        
    }
    
    
    NSInteger badge = [UIApplication sharedApplication].applicationIconBadgeNumber;
    badge --;
    badge = badge >= 0? badge: 0;
    [UIApplication sharedApplication].applicationIconBadgeNumber = badge;
    NSArray *localNotification = [UIApplication sharedApplication].scheduledLocalNotifications;
    for (UILocalNotification *notification in localNotification) {
        
        [[UIApplication sharedApplication] cancelLocalNotification:notification];
    }
    
    
    
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
