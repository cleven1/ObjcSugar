//
//  CDAUtils.m
//  native
//
//  Created by Edwin Cen on 9/18/16.
//  Copyright © 2016 camdora. All rights reserved.
//

#import "CDAUtils.h"
#include <ifaddrs.h>
#include <arpa/inet.h>
#import <SystemConfiguration/CaptiveNetwork.h>
#import "NSString+CDAExtend.h"

@implementation CDAUtils

/*
 NSString *format = @"%02d:%02d";
 if (time.durationInMinutes >= 3600) {
 format = @"%02d:%02d:%02d";
 }
 */
+ (NSString *)timeFormatted:(int)totalSeconds format: (NSString *)format
{
    int seconds = totalSeconds % 60;
    int minutes = (totalSeconds / 60) % 60;
    int hours = (totalSeconds / 60 / 60) % 24;
    if (!format) {
        if (totalSeconds >= 3600) {
            format = @"%02d'%02d'%02d\"";
        }else{
            format = @"%02d'%02d\"";
        }
    }
    //@"%02d'%02d\""
    if ([format numberOfOccurrencesOfString:@"%"] == 2) {
        return [NSString stringWithFormat:format, minutes, seconds];
    } else {
        return [NSString stringWithFormat:format, hours, minutes, seconds];
    }
}


+ (UIImage *)imageWithImage:(UIImage *)image convertToSize:(CGSize)size
{
    UIGraphicsBeginImageContext(size);
    [image drawInRect:CGRectMake(0, 0, size.width, size.height)];
    UIImage *destImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return destImage;
}

+ (UIImage *)imageWithImage:(UIImage *)image croptToRect:(CGRect)rect
{
    CGImageRef imageRef = CGImageCreateWithImageInRect([image CGImage], rect);
    UIImage *cropped = [UIImage imageWithCGImage:imageRef];
    CGImageRelease(imageRef);
    return cropped;
}


+ (UIImage *)imageWithImage:(UIImage *)image convertToSize:(CGSize)size andCroptToRect:(CGRect)rect
{
    return [CDAUtils imageWithImage:[CDAUtils imageWithImage:image croptToRect:rect] convertToSize:size];
}

+ (UIImage *)generateThumbnailWith:(UIImage *)image;
{
    CGFloat originWidth = image.size.width;
    CGFloat originHeight = image.size.height;
    BOOL isLandscape = originWidth > originHeight;
    CGFloat newWidth = isLandscape ? originHeight : originWidth;
    CGFloat newHeight = newWidth;
    CGFloat x = isLandscape ? (originWidth - newWidth) / 2 : 0;
    CGFloat y = isLandscape ? 0 : (originHeight - newHeight) / 2;
    CGRect croppedRect = CGRectMake(x, y, newWidth, newHeight);
    CGSize targetSize = CGSizeMake(60, 60);
    return [CDAUtils imageWithImage:image convertToSize:targetSize andCroptToRect:croppedRect];
}

+(UIImage *)blurredImageWithImage:(UIImage *)sourceImage
{
    
    //  Create our blurred image
    CIContext *context = [CIContext contextWithOptions:nil];
    CIImage *inputImage = [CIImage imageWithCGImage:sourceImage.CGImage];
    
    //  Setting up Gaussian Blur
    CIFilter *filter = [CIFilter filterWithName:@"CIGaussianBlur"];
    [filter setValue:inputImage forKey:kCIInputImageKey];
    [filter setValue:[NSNumber numberWithFloat:10.0f] forKey:@"inputRadius"];
    CIImage *result = [filter valueForKey:kCIOutputImageKey];
    
    /*  CIGaussianBlur has a tendency to shrink the image a little, this ensures it matches
     *  up exactly to the bounds of our original image */
    CGImageRef cgImage = [context createCGImage:result fromRect:[inputImage extent]];
    
    UIImage *retVal = [UIImage imageWithCGImage:cgImage];
    return retVal;
}

+(void)connectNetWork:(NSDictionary *)body VC:(UIViewController *)vc sureBlock:(void(^)())sureBlock cancelBlock:(void(^)())cancel
{

    NSString *title = body[@"title"] == nil ? NSLocalizedString(@"checkNetWork", nil) : body[@"title"];
    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:title message:body[@"message"] preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *sure = [UIAlertAction actionWithTitle:body[@"sureTitle"] style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        //跳到WiFi设置页面
        NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"prefs:root=%@",body[@"type"]]];
        if ([[UIApplication sharedApplication] canOpenURL:url]) {
            [[UIApplication sharedApplication] openURL:url];
        } else {
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"App-Prefs:root=%@",body[@"type"]]]];
        }
        sureBlock();
    }];
    [alertVC addAction:sure];
    UIAlertAction *c = [UIAlertAction actionWithTitle:NSLocalizedString(@"Cancel", nil) style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        cancel();
    }];
    [alertVC addAction:c];
    [vc presentViewController:alertVC animated:YES completion:nil];
    
}

+ (void)checkNetworkStatusWithVC:(UIViewController *)vc finish:(void(^)(NetworkStatus))finish cancel:(void (^)(BOOL isCancel))isCancel
{
    __weak typeof(vc) weakSelf = vc;
    NSString *message = @"";
    NetworkStatus status = ReachableViaWiFi;
    if (ReachableViaWiFi == [[CDAReachabilityManager sharedManager]checkNetworkStatus]) {
        status = ReachableViaWiFi;
        finish(status);
        return;
    }else if (ReachableViaWWAN == [[CDAReachabilityManager sharedManager]checkNetworkStatus]){
        status = ReachableViaWWAN;
        message = NSLocalizedString(@"checkNetworkStatus", nil);//@"当前网络为蜂窝网络,建议连接WiFi观看";
            finish(status);
        return;
    }else{
        message = NSLocalizedString(@"NotNetwork", nil);//@"手机没有网络,请连接蜂窝网络或WiFi";
        status = NotReachable;
    }
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:NSLocalizedString(@"DevicsUpgradeViewFlowTips", nil) message:message preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:NSLocalizedString(@"Cancel", nil) style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
        isCancel(YES);
    }];
    
    UIAlertAction *sure = [UIAlertAction actionWithTitle:NSLocalizedString(@"Ensure", nil) style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        finish(status);
    }];
    [alert addAction:cancel];
    [alert addAction:sure];
    
    [weakSelf presentViewController:alert animated:YES completion:nil];
    
}

//设置应该评分
+ (void)settingApplicationScoreWithAPPID:(NSString *)appId
{
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"itms-apps://itunes.apple.com/WebObjects/MZStore.woa/wa/viewContentsUserReviews?type=Purple+Software&id=%@",appId]]];
}

//获取View当前所在控制器
+ (UIViewController *)viewController:(UIView *)view
{
    UIViewController *viewController = nil;
    
    UIResponder *next = view.nextResponder;
    
    while (next)
    {
        if ([next isKindOfClass:[UIViewController class]])
        {
            viewController = (UIViewController *)next;
            
            break;
        }
        
        next = next.nextResponder;
        
    }
    
    return viewController;
    
}

+ (NSString *) formatByteToUnit:(long long)bytes
{
    if(bytes < 1024)     // B
    {
        return [NSString stringWithFormat:@"%.2lldB", bytes];
    }
    else if(bytes >= 1024 && bytes < 1024 * 1024) // KB
    {
        return [NSString stringWithFormat:@"%.1lldKB", bytes / 1024];
    }
    else if(bytes >= 1024 * 1024 && bytes < 1024 * 1024 * 1024)   // MB
    {
        return [NSString stringWithFormat:@"%.1lldMB", bytes / (1024 * 1024)];
    }
    else    // GB
    {
        return [NSString stringWithFormat:@"%.lldGB", bytes / (1024 * 1024 * 1024)];
    }
}


+(NSString *)getIPAddress
{
    NSString *address = @"error";
    struct ifaddrs *interfaces = NULL;
    struct ifaddrs *temp_addr = NULL;
    int success = 0;
    // retrieve the current interfaces - returns 0 on success
    success = getifaddrs(&interfaces);
    if (success == 0) {
        // Loop through linked list of interfaces
        temp_addr = interfaces;
        while(temp_addr != NULL) {
            if(temp_addr->ifa_addr->sa_family == AF_INET) {
                // Check if interface is en0 which is the wifi connection on the iPhone
                if([[NSString stringWithUTF8String:temp_addr->ifa_name] isEqualToString:@"en0"]) {
                    // Get NSString from C String
                    address = [NSString stringWithUTF8String:inet_ntoa(((struct sockaddr_in *)temp_addr->ifa_addr)->sin_addr)];
                    
                }
                
            }
            
            temp_addr = temp_addr->ifa_next;
        }
    }
    // Free memory
    freeifaddrs(interfaces);
    
    NSString *str = [address componentsSeparatedByString:@"."].lastObject;
    
    address = [address substringWithRange:NSMakeRange(0,address.length - str.length)];
    
    address = [NSString stringWithFormat:@"http://%@1",address];
    
    return address;
    
}

+ (NSString *)getSSID
{
    NSArray *ifs = (__bridge_transfer id)CNCopySupportedInterfaces();
    NSLog(@"interfaces:%@",ifs);
    NSDictionary *info = nil;
    for (NSString *ifname in ifs) {
        info = (__bridge_transfer NSDictionary *)CNCopyCurrentNetworkInfo((__bridge CFStringRef)ifname);
        NSLog(@"%@ => %@",ifname,info);
    }
    return info[@"SSID"];
}

#pragma mark - 生成二维码
+ (void)qrImageWithString:(NSString *)string avatar:(UIImage *)avatar completion:(void (^)(UIImage *))completion {
    [self qrImageWithString:string avatar:avatar scale:0.20 completion:completion];
}

+ (void)qrImageWithString:(NSString *)string avatar:(UIImage *)avatar scale:(CGFloat)scale completion:(void (^)(UIImage *))completion {
    
    NSAssert(completion != nil, @"必须传入完成回调");
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        
        CIFilter *qrFilter = [CIFilter filterWithName:@"CIQRCodeGenerator"];
        
        [qrFilter setDefaults];
        [qrFilter setValue:[string dataUsingEncoding:NSUTF8StringEncoding] forKey:@"inputMessage"];
        
        CIImage *ciImage = qrFilter.outputImage;
        
        CGAffineTransform transform = CGAffineTransformMakeScale(10, 10);
        CIImage *transformedImage = [ciImage imageByApplyingTransform:transform];
        
        CIContext *context = [CIContext contextWithOptions:nil];
        CGImageRef cgImage = [context createCGImage:transformedImage fromRect:transformedImage.extent];
        UIImage *qrImage = [UIImage imageWithCGImage:cgImage scale:[UIScreen mainScreen].scale orientation:UIImageOrientationUp];
        CGImageRelease(cgImage);
        
        if (avatar != nil) {
            qrImage = [self qrcodeImage:qrImage addAvatar:avatar scale:scale];
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{ completion(qrImage); });
    });
}

+ (UIImage *)qrcodeImage:(UIImage *)qrImage addAvatar:(UIImage *)avatar scale:(CGFloat)scale {
    
    CGFloat screenScale = [UIScreen mainScreen].scale;
    CGRect rect = CGRectMake(0, 0, qrImage.size.width * screenScale, qrImage.size.height * screenScale);
    
    UIGraphicsBeginImageContextWithOptions(rect.size, YES, screenScale);
    
    [qrImage drawInRect:rect];
    
    CGSize avatarSize = CGSizeMake(rect.size.width * scale, rect.size.height * scale);
    CGFloat x = (rect.size.width - avatarSize.width) * 0.5;
    CGFloat y = (rect.size.height - avatarSize.height) * 0.5;
    [avatar drawInRect:CGRectMake(x, y, avatarSize.width, avatarSize.height)];
    
    UIImage *result = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return [UIImage imageWithCGImage:result.CGImage scale:screenScale orientation:UIImageOrientationUp];
}

//根据中英文格式化数字
+ (NSString *)accordingToTheFormatNumbersInBothChineseAndEnglish:(NSInteger)number
{
    if([[self getPreferredLanguage] hasPrefix:@"zh"]){ // 当系统语言是中文或繁体中文时
        
        if (number >= 10000) {
            
            return [NSString stringWithFormat:@"%.1f万",number/10000.0];
        }else{
            
            return [NSString stringWithFormat:@"%ld",number];
        }
        
    }else{ //其它语言的情况下
        if (number >= 1000) {
            
            return [NSString stringWithFormat:@"%.1fk",number/1000.0];
        }else{
            
            return [NSString stringWithFormat:@"%ld",number];
        }

    }

}

//获取系统当前语言
+ (NSString*)getPreferredLanguage
{
    NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
    
    NSArray * allLanguages = [defaults objectForKey:@"AppleLanguages"];
    
    NSString * preferredLang = [allLanguages objectAtIndex:0];
    
    NSLog(@"当前语言:%@", preferredLang);
    
    return preferredLang;
    
}


@end
