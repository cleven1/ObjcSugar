//
//  CLFPSStatus.h
//  CLFPSStatusDemo
//
//  Created by cleven on 16/7/20.
//  Copyright © 2016年 cleven. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CLFPSStatus : NSObject

+ (CLFPSStatus *)shareInstance;
- (void)start;
- (void)end;

@end
