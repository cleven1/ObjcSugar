//
//  UIButton+CLObjcSugar.h
//  CLObjcSugar
//
//  Created by cleven on 16/3/21.
//  Copyright © 2016年 com.apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (CLObjcSugar)

/// 实例化 UIButton
///
/// @param title           title
/// @param fontSize        fontSize
/// @param textColor       textColor
///
/// @return UIButton
+ (nonnull instancetype)cl_buttonWithTitle:(nullable NSString *)title
                                  fontSize:(CGFloat)fontSize
                                 textColor:(nonnull UIColor *)textColor;

/// 实例化 UIButton
///
/// @param attributedText  attributedText
///
/// @return UIButton
+ (nonnull instancetype)cl_buttonWithAttributedText:(nullable NSAttributedString *)attributedText;

/// 实例化 UIButton
///
/// @param imageName       imageName
/// @param highlightSuffix highlightSuffix
///
/// @return UIButton
+ (nonnull instancetype)cl_buttonWithImageName:(nullable NSString *)imageName
                               highlightSuffix:(nullable NSString *)highlightSuffix;

/// 实例化 UIButton
///
/// @param imageName       imageName
/// @param backImageName   backImageName
/// @param highlightSuffix highlightSuffix
///
/// @return UIButton
+ (nonnull instancetype)cl_buttonWithImageName:(nullable NSString *)imageName
                                 backImageName:(nullable NSString *)backImageName
                               highlightSuffix:(nullable NSString *)highlightSuffix;

/// 实例化 UIButton
///
/// @param title           title
/// @param fontSize        fontSize
/// @param textColor       textColor
/// @param imageName       imageName
/// @param backImageName   backImageName
/// @param highlightSuffix highlightSuffix
///
/// @return UIButton
+ (nonnull instancetype)cl_buttonWithTitle:(nullable NSString *)title
                                  fontSize:(CGFloat)fontSize
                                 textColor:(nonnull UIColor *)textColor
                                 imageName:(nullable NSString *)imageName
                             backImageName:(nullable NSString *)backImageName
                           highlightSuffix:(nullable NSString *)highlightSuffix;

/// 实例化 UIButton
///
/// @param attributedText  attributedText
/// @param imageName       imageName
/// @param backImageName   backImageName
/// @param highlightSuffix highlightSuffix
///
/// @return UIButton
+ (nonnull instancetype)cl_buttonWithAttributedText:(nullable NSAttributedString *)attributedText
                                          imageName:(nullable NSString *)imageName
                                      backImageName:(nullable NSString *)backImageName
                                    highlightSuffix:(nullable NSString *)highlightSuffix;

@end
