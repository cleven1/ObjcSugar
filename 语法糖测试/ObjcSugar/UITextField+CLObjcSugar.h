//
//  UITextField+CLObjcSugar.h
//  CLObjcSugar
//
//  Created by cleven on 16/3/24.
//  Copyright © 2016年 com.apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITextField (CLObjcSugar)

/// 实例化 UITextField
///
/// @param placeHolder     占位文本
///
/// @return UITextField
+ (nonnull instancetype)cl_textFieldWithPlaceHolder:(nonnull NSString *)placeHolder;

@end
