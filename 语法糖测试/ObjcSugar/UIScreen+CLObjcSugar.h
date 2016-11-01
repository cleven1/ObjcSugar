//
//  UIScreen+CLObjcSugar.h
//  CLObjcSugar
//
//  Created by cleven on 16/3/20.
//  Copyright © 2016年 com.apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIScreen (CLObjcSugar)

/// 屏幕宽度
+ (CGFloat)cl_screenWidth;
/// 屏幕高度
+ (CGFloat)cl_screenHeight;
/// 分辨率
+ (CGFloat)cl_scale;

@end
