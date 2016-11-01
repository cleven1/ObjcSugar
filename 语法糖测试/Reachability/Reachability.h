/*
 Copyright (C) 2016 Apple Inc. All Rights Reserved.
 See LICENSE.txt for this sample’s licensing information
 
 Abstract:
 Basic demonstration of how to use the SystemConfiguration Reachablity APIs.
 
 
 
 //添加网络监测
 [[NSNotificationCenter defaultCenter] addObserver:self
 selector:@selector(reachabilityChanged:)
 name: kReachabilityChangedNotification
 object: nil];
 
 //开启网络监测
 self.intertReach = [Reachability reachabilityForInternetConnection];
 [self.intertReach startNotifier];
 
 UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(100, 100, 300, 30)];
 [self.view addSubview:label];
 self.label = label;
 
 //获取当前的网络状态
 NetworkStatus status = [self.intertReach currentReachabilityStatus];
 [self judgeNetWorkStatus:status];
 
 }
 
 **
 当网络状态发生变换时 会触发这个方法
 
 @param no 通知

- (void)reachabilityChanged:(NSNotification *)no{
    Reachability* curReach = [no object];
    NSParameterAssert([curReach isKindOfClass: [Reachability class]]);
    NetworkStatus status = [curReach currentReachabilityStatus];
    [self judgeNetWorkStatus:status];
}

 
 判断当前的网络状态
 
 @param status 当前的网络状态
- (void)judgeNetWorkStatus:(NetworkStatus)status{
    
    switch (status){
            
        case NotReachable:
            NSLog(@"没网");
            //其他处理
            self.label.text = @"没网";
            break;
            
        case ReachableViaWiFi:
            NSLog(@"WiFi");
            self.label.text = @"WiFi";
            //其他处理
            break;
        case kReachableVia2G:
            NSLog(@"2G");
            self.label.text = @"2G";
            break;
        case kReachableVia3G:
            NSLog(@"3G");
            //其他处理
            self.label.text = @"3G";
            break;
        case kReachableVia4G:
            NSLog(@"4G");
            self.label.text = @"4G";
            //其他处理
            break;
        default:
            NSLog(@"你连的隔壁老王的网吗？");
            //其他处理
            self.label.text = @"你连的隔壁老王的网吗？";
            break;
    }
}

 */

#import <Foundation/Foundation.h>
#import <SystemConfiguration/SystemConfiguration.h>
#import <netinet/in.h>
#import <CoreTelephony/CTTelephonyNetworkInfo.h>


typedef enum : NSInteger {
	NotReachable = 0,
	ReachableViaWiFi,
	ReachableViaWWAN,
    kReachableVia2G,
    kReachableVia3G,
    kReachableVia4G
} NetworkStatus;

#pragma mark IPv6 Support
//Reachability fully support IPv6.  For full details, see ReadMe.md.


extern NSString *kReachabilityChangedNotification;


@interface Reachability : NSObject

/*!
 * Use to check the reachability of a given host name.
 */
+ (instancetype)reachabilityWithHostName:(NSString *)hostName;

/*!
 * Use to check the reachability of a given IP address.
 */
+ (instancetype)reachabilityWithAddress:(const struct sockaddr *)hostAddress;

/*!
 * Checks whether the default route is available. Should be used by applications that do not connect to a particular host.
 */
+ (instancetype)reachabilityForInternetConnection;


#pragma mark reachabilityForLocalWiFi
//reachabilityForLocalWiFi has been removed from the sample.  See ReadMe.md for more information.
//+ (instancetype)reachabilityForLocalWiFi;

/*!
 * Start listening for reachability notifications on the current run loop.
 */
- (BOOL)startNotifier;
- (void)stopNotifier;

- (NetworkStatus)currentReachabilityStatus;

/*!
 * WWAN may be available, but not active until a connection has been established. WiFi may require a connection for VPN on Demand.
 */
- (BOOL)connectionRequired;

@end


