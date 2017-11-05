//
//  UIImage+SuperCompress.h
//  iOS-Categories (https://github.com/shaojiankui/iOS-Categories)
//
//  Created by Jakey on 16/1/22.
//  Copyright © 2016年 Jakey. All rights reserved.
//  https://github.com/CompletionHandler/CYImageCompress

//usage      [UIImage compressImage:image toMaxLength:512*1024*8 maxWidth:1024];

#import <UIKit/UIKit.h>

@interface UIImage (SuperCompress)
/**
 等比例缩放

 @param image 原始图片
 @param size  size

 @return 调整后的图片
 */
+(UIImage*)scaleImage:(UIImage *)image ToSize:(CGSize)size;

///对指定图片进行拉伸
+ (UIImage*)resizableImage:(NSString *)name;
@end
