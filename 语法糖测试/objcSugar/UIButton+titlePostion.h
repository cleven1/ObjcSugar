//
//  UIButton+titlePostion.h
//  CLButtonCategory
//
//  Created by mini on 16/8/30.
//  Copyright © 2016年 com.apple All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_ENUM(NSInteger,postionType) {
    TypeLeft = 0,
    TypeBottom,
};
@interface UIButton (titlePostion)
/**
 *  设置title显示的位置
 *
 *  @param Type 支持左边和底部
 */
- (void)CLSetbuttonType:(postionType)Type;


/**
 *  扩大按钮点击范围（insets必须不被button的superview给挡住）
 */
@property (nonatomic, assign) UIEdgeInsets hitEdgeInsets;

/**
 *  通过字体来设置button的frame
 *
 *  @param width    宽
 *  @param fontSize 字体大小
 *  @param str      title
 *
 *  @return <#return value description#>
 */
+(CGSize)sizeOfLabelWithCustomMaxWidth:(CGFloat)width systemFontSize:(CGFloat)fontSize andFilledTextString:(NSString *)str;

@end
