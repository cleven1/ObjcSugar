//
//  CDAUtils.h
//  native
//
//  Created by Edwin Cen on 9/18/16.
//  Copyright © 2016 camdora. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CDAReachability.h"

@interface CDAUtils : NSObject

+ (NSString *)timeFormatted:(int)totalSeconds format: (NSString *)format;
+ (UIImage *)imageWithImage:(UIImage *)image convertToSize:(CGSize)size;
+ (UIImage *)imageWithImage:(UIImage *)image croptToRect:(CGRect)rect;
+ (UIImage *)imageWithImage:(UIImage *)image convertToSize:(CGSize)size andCroptToRect:(CGRect)rect;
+ (UIImage *)generateThumbnailWith:(UIImage *)image;
+ (UIImage *)blurredImageWithImage:(UIImage *)sourceImage;

/*
 [CDAUtils connectNetWork:@{
 @"message":@"建议连接蜂窝网络",
 @"sureTitle":@"连接蜂窝网络",
 @"type":@"General&path=ACCESSIBILITY"
 } VC:self];
 */
+(void)connectNetWork:(NSDictionary *)body VC:(UIViewController *)vc sureBlock:(void(^)())sureBlock cancelBlock:(void(^)())cancel;

///  字节格式化
///
///  @param bytes bytes
///
///  @return NSString
+ (NSString *) formatByteToUnit:(long long)bytes;

///  设置应用评分
///
///  @param appId APPId
+ (void)settingApplicationScoreWithAPPID:(NSString *)appId;

///  获取View当前所在控制器
///
///  @param view View
///
///  @return 控制器
+ (UIViewController *)viewController:(UIView *)view;

///  确认网络状态
///
///  @param vc 当前控制器
+ (void)checkNetworkStatusWithVC:(UIViewController *)vc finish:(void(^)(NetworkStatus))finish cancel:(void (^)(BOOL isCancel))isCancel;

///  判断相机是否是camdoraDevice
///
///  @param deviceType deviceType
///
///  @return yes= Camdora Device 
+ (BOOL)checkDeviceTypeIsCamdoraDevice:(NSString *)deviceType;

///  获取连接WIFI IP
///
///  @return ip
+ (NSString *)getIPAddress;

///  获取SSID
///
///  @return ssid
+ (NSString *)getSSID;

/// 使用 string / 头像 异步生成二维码图像，并且指定头像占二维码图像的比例
///
/// @param string     二维码图像的字符串
/// @param avatar     头像图像
/// @param scale      头像占二维码图像的比例
/// @param completion 完成回调
+ (void)qrImageWithString:(NSString *)string avatar:(UIImage *)avatar scale:(CGFloat)scale completion:(void (^)(UIImage *))completion;

//根据中英文格式化数字
+ (NSString *)accordingToTheFormatNumbersInBothChineseAndEnglish:(NSInteger)number;

@end
