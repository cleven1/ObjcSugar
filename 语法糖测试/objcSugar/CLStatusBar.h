//
//  CDAStatusBar.h
//  Camdora
//
//  Created by 赵永强 on 2017/8/3.
//  Copyright © 2017年 camdora. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CLStatusBar : NSObject


/**
 设置statusBar隐藏与显示

 @param hidden 隐藏
 */
+ (void)setStatusBarHidden:(BOOL)hidden;


/**
 设置statusBar颜色

 @param color 要更改的颜色
 */
+ (void)setStatusBarBackgroundColor:(UIColor *)color;

/**
 更新statusBar Icon颜色

 @param color 要更改的颜色
 */
//+ (void)updateStatusbarIconColor:(UIColor *)color;

@end
