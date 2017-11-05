//
//  CDA Reachability.h
//  native
//
//  Created by Edwin Cen on 9/10/16.
//  Copyright © 2016 camdora. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"

typedef void (^wifiReachabilityChangedBlock)(BOOL isConnectDeviceWifi);
typedef void (^CDAWifiReachabilityChangedBlock)(BOOL isConnectDeviceWifi, NSString *ssid);

typedef enum : NSInteger {
    NotReachable = 0,
    ReachableViaWiFi,
    ReachableViaWWAN
} NetworkStatus;

@interface CDAReachabilityManager : NSObject

@property (nonatomic, assign) BOOL wifiReachability;

+ (instancetype)sharedManager;

- (void) setReachabilityStatusChangedBlock: (CDAWifiReachabilityChangedBlock)block;
- (void) setConnectWifiBlock: (wifiReachabilityChangedBlock)block;
- (NetworkStatus)currentReachabilityStatus;
- (NetworkStatus)checkNetworkStatus;
- (void) resumeNetworkDetector;
- (void) suspendNetworkDetector;
- (NSString *) getCurrentNetworkSSID;

@end
