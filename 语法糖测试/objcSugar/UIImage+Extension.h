//
//  UIImage+Extension.h
//
//  Created by cleven on 16/3/20.
//  Copyright © 2016年 com.apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Extension)


/**
 本地图片裁剪

 @param image    要裁剪的图片
 @param imgeSize 裁剪size

 @return 返回图片
 */
- (UIImage *)rightSizeImage:(UIImage *)image andSize:(CGSize)imgeSize;

/**
 异步裁剪图片

 @param image      要裁剪的图片
 @param imgeSize   裁剪size
 @param completion 完成回调
 */
- (void)rightSizeImage:(UIImage *)image andSize:(CGSize)imgeSize completion:(void (^)(UIImage *))completion;



/**
 异步生成圆角图像

 @param size         图片size
 @param fillColor    填充颜色
 @param cornerRadius 圆角
 @param completion   回调
 */
- (void)cornerImageWithSize:(CGSize)size fillColor:(UIColor *)fillColor cornerRadius:(CGFloat)cornerRadius completion:(void (^)(UIImage *))completion;

/**
 等比例缩放
 
 @param image 原始图片
 @param size  size
 
 @return 调整后的图片
 */
+(UIImage*)scaleImage:(UIImage *)image ToSize:(CGSize)size;

//截取指定位置的图
- (void)imageScaleWithImage:(UIImage*) image
                  withWidth:(CGFloat ) width
                 withHeight:(CGFloat) height
                 completion:(void (^)(UIImage *))completion;

//通过URL获取视频第一帧图
+ (void) thumbnailImageForVideo:(NSURL *)videoURL atTime:(NSTimeInterval)time completion:(void (^)(UIImage *))completion;

/**
 *  重新绘制图片
 *
 *  @param color 填充色
 *
 *  @return UIImage
 */
- (UIImage *)imageWithColor:(UIColor *)color;

@end
