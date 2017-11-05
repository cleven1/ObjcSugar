
#import <UIKit/UIKit.h>

@interface LocalPushCenter : NSObject

#pragma mark - 在AppDelegate中注册
+(void)registerLocalNotificationInAppDelegate;

#pragma mark - 注册本地通知
+ (void)registerLocalNotification:(NSInteger)alertTime;

#pragma mark - 退出
+ (void)cancelAllLocalPhsh;

+ (void)cancleLocalPushWithKey:(NSString *)key;

@end
