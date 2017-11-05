//
//  UIImage+Extension.m
//
//  Created by cleven on 16/3/20.
//  Copyright © 2016年 com.apple. All rights reserved.
//

#import "UIImage+Extension.h"
#import <AVFoundation/AVFoundation.h>

@implementation UIImage (Extension)


- (UIImage *)rightSizeImage:(UIImage *)image andSize:(CGSize)imgeSize{
    //根据 imageView 的大小，重新调整 image 的大小
    // 使用 CG 重新生成一张和目标尺寸相同的图片
    UIGraphicsBeginImageContextWithOptions(imgeSize, YES, [UIScreen mainScreen].scale);
    // 绘制图像
    [image drawInRect:CGRectMake(0, 0, imgeSize.width, imgeSize.height)];

    UIImage *result = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    return result;
}


- (void)rightSizeImage:(UIImage *)image andSize:(CGSize)imgeSize completion:(void (^)(UIImage *))completion{
    
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        
        UIGraphicsBeginImageContextWithOptions(imgeSize, YES, [UIScreen mainScreen].scale);
    
        CGRect rect = CGRectMake(0, 0, imgeSize.width, imgeSize.height);
        UIColor *color = [UIColor whiteColor];
        [color setFill];
        UIRectFill(rect);
        
        
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
        UIGraphicsBeginImageContextWithOptions(size, YES, [UIScreen mainScreen].scale);
        
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
/**
 * @breif 等比例缩放
 */
+(UIImage*)scaleImage:(UIImage *)image ToSize:(CGSize)size
{
    CGFloat width = CGImageGetWidth(image.CGImage);
    CGFloat height = CGImageGetHeight(image.CGImage);
    
    float verticalRadio = size.height*1.0/height;
    float horizontalRadio = size.width*1.0/width;
    
    float radio = 1;
    if(verticalRadio>1 && horizontalRadio>1){
        radio = verticalRadio > horizontalRadio ? horizontalRadio : verticalRadio;
    }else{
        radio = verticalRadio > horizontalRadio ? verticalRadio : horizontalRadio;
    }
    
    width = width*radio;
    height = height*radio;
    
    int xPos = (size.width - width)/2;
    int yPos = (size.height-height)/2;
    
    // 创建一个bitmap的context
    UIGraphicsBeginImageContext(size);
    [image drawInRect:CGRectMake(xPos, yPos, width, height)];
    UIImage* scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return scaledImage;
}

//截取指定位置的图
- (void)imageScaleWithImage:(UIImage*) image
                       withWidth:(CGFloat ) width
                      withHeight:(CGFloat) height
                      completion:(void (^)(UIImage *))completion
{
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
       
        EAGLContext *previousContext = [EAGLContext currentContext];
        [EAGLContext setCurrentContext:nil];
        CIImage *ciimage = [CIImage imageWithCGImage:image.CGImage];
        CGFloat imageWidth = ciimage.extent.size.width;
        CGFloat imageHeight = ciimage.extent.size.height;
        CGFloat srcRatio = imageWidth/(imageHeight*1.0);
        CGFloat desRatio = width/(height*1.0);
        
        CIContext *context = [CIContext contextWithOptions:nil];
        
        //scale
        CGFloat scale = srcRatio < desRatio ? (width/imageWidth) : (height/imageHeight);
        ciimage = [ciimage imageByApplyingTransform:CGAffineTransformMakeScale(scale, scale)];
        
        CGRect extent = ciimage.extent;
        CGRect resultRect = CGRectMake(0, 0, width, height);//CGRectMake(extent.origin.x+(extent.size.width - width)/2, extent.origin.y+(extent.size.height - height)/2, width, height);
        CGImageRef ref = [context createCGImage:ciimage fromRect:resultRect];
        UIImage *resultImage = [UIImage imageWithCGImage:ref];
        [EAGLContext setCurrentContext:previousContext];
        
        dispatch_async(dispatch_get_main_queue(), ^{
           
            if (resultImage) {
                completion(resultImage);
            }
            
        });
    });
    
}

//获取视频第一帧图
+ (void) thumbnailImageForVideo:(NSURL *)videoURL atTime:(NSTimeInterval)time completion:(void (^)(UIImage *))completion{
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        
        AVURLAsset *asset = [[AVURLAsset alloc] initWithURL:videoURL options:nil];
        NSParameterAssert(asset);
        AVAssetImageGenerator *assetImageGenerator =[[AVAssetImageGenerator alloc] initWithAsset:asset];
        assetImageGenerator.appliesPreferredTrackTransform = YES;
        assetImageGenerator.apertureMode = AVAssetImageGeneratorApertureModeEncodedPixels;
        
        CGImageRef thumbnailImageRef = NULL;
        CFTimeInterval thumbnailImageTime = time;
        NSError *thumbnailImageGenerationError = nil;
        thumbnailImageRef = [assetImageGenerator copyCGImageAtTime:CMTimeMake(thumbnailImageTime, 60)actualTime:NULL error:&thumbnailImageGenerationError];
        
        if(!thumbnailImageRef)
            NSLog(@"thumbnailImageGenerationError %@",thumbnailImageGenerationError);
        
        UIImage*thumbnailImage = thumbnailImageRef ? [[UIImage alloc]initWithCGImage: thumbnailImageRef] : nil;
        
        completion(thumbnailImage);
    });
    
}

/**
 *  重新绘制图片
 *
 *  @param color 填充色
 *
 *  @return UIImage
 */
- (UIImage *)imageWithColor:(UIColor *)color
{
    UIGraphicsBeginImageContextWithOptions(self.size, NO, self.scale);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextTranslateCTM(context, 0, self.size.height);
    CGContextScaleCTM(context, 1.0, -1.0);
    CGContextSetBlendMode(context, kCGBlendModeNormal);
    CGRect rect = CGRectMake(0, 0, self.size.width, self.size.height);
    CGContextClipToMask(context, rect, self.CGImage);
    [color setFill];
    CGContextFillRect(context, rect);
    UIImage*newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

@end
