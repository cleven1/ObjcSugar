//
//  UIImage+CLObjcSugar.m
//  CLObjcSugar
//
//  Created by cleven on 16/3/21.
//  Copyright © 2016年 com.apple. All rights reserved.
//

#import "UIImage+CLObjcSugar.h"

@implementation UIImage (CLObjcSugar)

+ (UIImage *)cl_singleDotImageWithColor:(UIColor *)color {
    
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(1, 1), YES, 0);
    
    [color setFill];
    UIRectFill(CGRectMake(0, 0, 1, 1));
    
    UIImage *result = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return result;
}

#pragma mark - 图片水印
+ (instancetype)waterImageWithBg:(NSString *)bg logo:(NSString *)logo
{
    UIImage *bgImage = [UIImage imageNamed:bg];
    // 上下文 : 基于位图(bitmap) ,  所有的东西需要绘制到一张新的图片上去
    // 1.创建一个基于位图的上下文(开启一个基于位图的上下文)
    // size : 新图片的尺寸
    // opaque : YES : 不透明,  NO : 透明
    // 这行代码过后.就相当于创建一张新的bitmap,也就是新的UIImage对象
    UIGraphicsBeginImageContextWithOptions(bgImage.size, NO, 0.0);
    
    // 画背景
    [bgImage drawInRect:CGRectMake(0, 0, bgImage.size.width, bgImage.size.height)];
    
    // 画右下角的水印
    UIImage *logoImage = [UIImage imageNamed:logo];
    CGFloat scale = 0.3;
    CGFloat logoW = logoImage.size.width * scale;
    CGFloat logoH = logoImage.size.height * scale;
    CGFloat margin = 5;
    CGFloat logoX = bgImage.size.width - logoW - margin;
    CGFloat logoY = bgImage.size.height - logoH - margin;
    CGRect rect = CGRectMake(logoX, logoY, logoW, logoH);
    [logoImage drawInRect:rect];
    
    // 从上下文中取得制作完毕的UIImage对象
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    // 结束上下文
    UIGraphicsEndImageContext();
    
    return newImage;
}


@end
