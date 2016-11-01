//
//  UIImage+Extension.m
//
//  Created by cleven on 16/3/20.
//  Copyright © 2016年 com.apple. All rights reserved.
//

#import "UIImage+Extension.h"

@implementation UIImage (Extension)


- (UIImage *)rightSizeImage:(UIImage *)image andSize:(CGSize)imgeSize{
    //根据 imageView 的大小，重新调整 image 的大小
    // 使用 CG 重新生成一张和目标尺寸相同的图片
    UIGraphicsBeginImageContextWithOptions(imgeSize, YES, 0);
    // 绘制图像
    [image drawInRect:CGRectMake(0, 0, imgeSize.width, imgeSize.height)];

    UIImage *result = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    return result;
}


- (void)rightSizeImage:(UIImage *)image andSize:(CGSize)imgeSize completion:(void (^)(UIImage *))completion{
    
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        UIGraphicsBeginImageContextWithOptions(imgeSize, YES, 0);
    
        [image drawInRect:CGRectMake(0, 0, imgeSize.width, imgeSize.height)];
        
        UIImage *result = UIGraphicsGetImageFromCurrentImageContext();
        
        UIGraphicsEndImageContext();
        
        dispatch_async(dispatch_get_main_queue(), ^{
            if (completion != nil) {
                completion(result);
            }
        });
    });
}



/**
 如何回调：block - iOS 开发中，block最多的用途就是在异步执行完成之后，通过参数回调通知调用方结果！
 */
- (void)cornerImageWithSize:(CGSize)size fillColor:(UIColor *)fillColor cornerRadius:(CGFloat)cornerRadius completion:(void (^)(UIImage *))completion{
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        
        //        NSTimeInterval start = CACurrentMediaTime();
        UIGraphicsBeginImageContextWithOptions(size, YES, 0);
        
        CGRect rect = CGRectMake(0, 0, size.width, size.height);
        
        [fillColor setFill];
        UIRectFill(rect);
        
        // 利用 贝赛尔路径 `裁切 效果
        //        UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:rect];
        UIBezierPath *path = [UIBezierPath  bezierPathWithRoundedRect:rect cornerRadius:cornerRadius];
        
        [path addClip];
        
        [self drawInRect:rect];
        
        UIImage *result = UIGraphicsGetImageFromCurrentImageContext();
        
        UIGraphicsEndImageContext();
        
        //        NSLog(@"%f", CACurrentMediaTime() - start);
        
        //完成回调
        dispatch_async(dispatch_get_main_queue(), ^{
            if (completion != nil) {
                completion(result);
            }
        });
    });
}

@end
