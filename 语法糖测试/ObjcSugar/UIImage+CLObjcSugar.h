//
//  UIImage+CLObjcSugar.h
//  CLObjcSugar
//
//  Created by cleven on 16/3/21.
//  Copyright © 2016年 com.apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (CLObjcSugar)

/// 生成指定颜色的一个`点`的图像
///
/// @param color 颜色
///
/// @return 1 * 1 图像
+ (nonnull UIImage *)cl_singleDotImageWithColor:(nonnull UIColor *)color;

@end
