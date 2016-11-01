//
//  UIImage+Extension.h
//
//  Created by cleven on 16/10/25.
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
@end
