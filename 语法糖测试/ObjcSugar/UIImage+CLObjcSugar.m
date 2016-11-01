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

@end
