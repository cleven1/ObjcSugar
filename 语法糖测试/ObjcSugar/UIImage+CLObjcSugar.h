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

/**
 *  水印图片
 *
 *  @param bg  背景图片名字
 *  @param logo logo图片名字
 *
 */
+ (nonnull instancetype)waterImageWithBg:(nonnull NSString *)bg logo:(nonnull NSString *)logo;

/**
 *  重新绘制图片
 *
 *  @param color 填充色
 *
 *  @return UIImage
 */
- (nonnull UIImage *)imageWithColor:(nonnull UIColor *)color;
@end
