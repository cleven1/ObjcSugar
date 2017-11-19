//
//  UIApplication+Visible.h
//  Camdora
//
//  Created by tusm on 2017/3/3.
//  Copyright © 2017年 camdora. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CDANavigationViewController;

@interface UIApplication (Visible)
- (CDANavigationViewController *)visibleNavigationController;
@end
