//
//  UIView+cornerRadius.h
//  test
//
//  Created by mini on 16/8/24.
//  Copyright © 2016年 mini. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (cornerRadius)

-(void)setCornerRadius:(CGFloat)radius;

-(void)setCornerRadius:(CGFloat)radius borderWidth:(CGFloat)borderWidth borderColor:(UIColor*)borderColor;

@end
