//
//  UIDevice+CL.m
//  Camdora
//
//  Created by tusm on 2017/2/11.
//  Copyright © 2017年 camdora. All rights reserved.
//

#import "UIDevice+CL.h"

@implementation UIDevice (CL)

//调用私有方法实现
+ (void)setOrientation:(UIInterfaceOrientation)orientation {
    SEL selector = NSSelectorFromString(@"setOrientation:");
    NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:[self instanceMethodSignatureForSelector:selector]];
    [invocation setSelector:selector];
    [invocation setTarget:[self currentDevice]];
    int val = orientation;
    [invocation setArgument:&val atIndex:2];
    [invocation invoke];
}

@end
