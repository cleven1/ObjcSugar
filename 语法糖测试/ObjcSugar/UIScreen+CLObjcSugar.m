//
//  UIScreen+CLObjcSugar.m
//  CLObjcSugar
//
//  Created by cleven on 16/3/20.
//  Copyright © 2016年 com.apple. All rights reserved.
//

#import "UIScreen+CLObjcSugar.h"

@implementation UIScreen (CLObjcSugar)

+ (CGFloat)cl_screenWidth {
    return [UIScreen mainScreen].bounds.size.width;
}

+ (CGFloat)cl_screenHeight {
    return [UIScreen mainScreen].bounds.size.height;
}

+ (CGFloat)cl_scale {
    return [UIScreen mainScreen].scale;
}

@end
