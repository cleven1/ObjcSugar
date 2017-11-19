//
//  UIApplication+Visible.m
//  Camdora
//
//  Created by tusm on 2017/3/3.
//  Copyright © 2017年 camdora. All rights reserved.
//

#import "UIApplication+Visible.h"
#import "CDANavigationViewController.h"

@implementation UIApplication (Visible)
- (UIWindow *)mainWindow {
    return self.delegate.window;
}

- (UIViewController *)visibleViewController {
    UIViewController *rootViewController = [self.mainWindow rootViewController];
    return [self getVisibleViewControllerFrom:rootViewController];
}

- (UIViewController *) getVisibleViewControllerFrom:(UIViewController *) vc {
    if ([vc isKindOfClass:[CDANavigationViewController class]]) {
        return [self getVisibleViewControllerFrom:[((CDANavigationViewController *) vc) visibleViewController]];
    } else if ([vc isKindOfClass:[UITabBarController class]]) {
        return [self getVisibleViewControllerFrom:[((UITabBarController *) vc) selectedViewController]];
    } else {
        if (vc.presentedViewController) {
            return [self getVisibleViewControllerFrom:vc.presentedViewController];
        } else {
            return vc;
        }
    }
    
}

- (CDANavigationViewController *)visibleNavigationController {
    return (CDANavigationViewController *)[[self visibleViewController] navigationController];
}
@end
