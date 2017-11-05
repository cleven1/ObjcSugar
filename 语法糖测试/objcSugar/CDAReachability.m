//
//  CDA Reachability.m
//  native
//
//  Created by Edwin Cen on 9/10/16.
//  Copyright © 2016 camdora. All rights reserved.
//

#import <arpa/inet.h>
#import <ifaddrs.h>
#import <netdb.h>
#import <sys/socket.h>
#import <netinet/in.h>
#import "CDAReachability.h"
#import <SystemConfiguration/CaptiveNetwork.h>

@implementation CDAReachabilityManager
{
    dispatch_source_t _wifiTimer;
    CDAWifiReachabilityChangedBlock _changedBlock;
    wifiReachabilityChangedBlock _connectWifiBlock;
    SCNetworkReachabilityRef _reachabilityRef;
    NSString *_currentSSID;
}

+ (instancetype)sharedManager
{
    static CDAReachabilityManager *_manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _manager = [[CDAReachabilityManager alloc] init];
    });
    return _manager;
}

- (id) init
{
    self = [super init];
    if (self) {
        _wifiReachability = NO;
        struct sockaddr_in zeroAddress;
        bzero(&zeroAddress, sizeof(zeroAddress));
        zeroAddress.sin_len = sizeof(zeroAddress);
        zeroAddress.sin_family = AF_INET;
        _reachabilityRef = SCNetworkReachabilityCreateWithAddress(kCFAllocatorDefault, (const struct sockaddr *) &zeroAddress);

    }
    return self;
}

- (void)dealloc
{
    dispatch_source_cancel(_wifiTimer);
    _wifiTimer = NULL;
}

- (void) resumeNetworkDetector
{
    if (_wifiTimer) {
        [self suspendNetworkDetector];
    }
    dispatch_source_t timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, dispatch_get_main_queue());
    dispatch_source_set_timer(timer, DISPATCH_TIME_NOW, 0.2*NSEC_PER_SEC, 0.0);
    dispatch_source_set_event_handler(timer, ^{
        NSString *ssid = [self getCurrentNetworkSSID];
        if (![_currentSSID isEqualToString:ssid]) {
            _currentSSID = ssid;
//            if ([_currentSSID isEqualToString:@""] || ![CDADeviceUtils checkIfConnectToDeviceWifiWithSSID:_currentSSID])
//            {
//                _wifiReachability = NO;
//                if (NULL != _changedBlock) {
//                    _changedBlock(NO, ssid);
//                }
//                if (NULL != _connectWifiBlock) {
//                    if ([self checkNetworkStatus]) {
//                        _connectWifiBlock(YES);
//                    } else {
//                        _connectWifiBlock(NO);
//                    }                    
//                }
//            }
//            else {
//                _wifiReachability = YES;
//                if (NULL != _changedBlock) {
//                    _changedBlock(YES, ssid);
//                }
//            }
        } 
    });
    _wifiTimer = timer;
    dispatch_resume(_wifiTimer);
}

- (void) suspendNetworkDetector
{
    dispatch_source_cancel(_wifiTimer);
    _wifiTimer = NULL;
}

- (void) setReachabilityStatusChangedBlock:(CDAWifiReachabilityChangedBlock)block
{
    if (NULL != block) {
        _changedBlock = block;
    }
}

- (void) setConnectWifiBlock:(wifiReachabilityChangedBlock)block
{
    if (NULL != block) {
        _connectWifiBlock = block;
    }
}

- (NSString *) getCurrentNetworkSSID
{
    // see http://stackoverflow.com/a/5198968/907720
    NSArray *ifs = (__bridge_transfer NSArray *)CNCopySupportedInterfaces();
    NSDictionary *info;
    for (NSString *ifnam in ifs) {
        info = (__bridge_transfer NSDictionary *)CNCopyCurrentNetworkInfo((__bridge CFStringRef)ifnam);
        //         NSLog(@"%@ => %@", ifnam, info);
        if (info && [info count]) { break; }
    }
    if (info == nil) {
        return @"";
    } else {
        NSString *ssid = [info objectForKey:@"SSID"];
        if (ssid) {
            return ssid;
        } else {
            return @"";
        }
    }
}

- (NetworkStatus)currentReachabilityStatus
{
    NSAssert(_reachabilityRef != NULL, @"currentNetworkStatus called with NULL SCNetworkReachabilityRef");
    NetworkStatus returnValue = NotReachable;
    SCNetworkReachabilityFlags flags;
    
    if (SCNetworkReachabilityGetFlags(_reachabilityRef, &flags))
    {
        returnValue = [self networkStatusForFlags:flags];
    }
    
    return returnValue;
}

- (NetworkStatus)networkStatusForFlags:(SCNetworkReachabilityFlags)flags
{
    if ((flags & kSCNetworkReachabilityFlagsReachable) == 0)
    {
        // The target host is not reachable.
        return NotReachable;
    }
    
    NetworkStatus returnValue = NotReachable;
    
    if ((flags & kSCNetworkReachabilityFlagsConnectionRequired) == 0)
    {
        /*
         If the target host is reachable and no connection is required then we'll assume (for now) that you're on Wi-Fi...
         */
        returnValue = ReachableViaWiFi;
    }
    
    if ((((flags & kSCNetworkReachabilityFlagsConnectionOnDemand ) != 0) ||
         (flags & kSCNetworkReachabilityFlagsConnectionOnTraffic) != 0))
    {
        /*
         ... and the connection is on-demand (or on-traffic) if the calling application is using the CFSocketStream or higher APIs...
         */
        
        if ((flags & kSCNetworkReachabilityFlagsInterventionRequired) == 0)
        {
            /*
             ... and no [user] intervention is needed...
             */
            returnValue = ReachableViaWiFi;
        }
    }
    
    if ((flags & kSCNetworkReachabilityFlagsIsWWAN) == kSCNetworkReachabilityFlagsIsWWAN)
    {
        /*
         ... but WWAN connections are OK if the calling application is using the CFNetwork APIs.
         */
        returnValue = ReachableViaWWAN;
    }
    
    return returnValue;
}

- (NetworkStatus)checkNetworkStatus
{
    NetworkStatus status = [self currentReachabilityStatus];
    switch (status) {
        case NotReachable:
            return NotReachable;
            break;
        case ReachableViaWiFi:
            return ReachableViaWiFi;
            break;
        case ReachableViaWWAN:
            return ReachableViaWWAN;
            break;
        default:
            return NO;
            break;
    }
}

@end
