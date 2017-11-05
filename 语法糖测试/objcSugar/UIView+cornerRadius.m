//
//  UIView+cornerRadius.m
//  test
//
//  Created by mini on 16/8/24.
//  Copyright © 2016年 mini. All rights reserved.
//

#import "UIView+cornerRadius.h"

@implementation UIView (cornerRadius)

-(void)setCornerRadius:(CGFloat)radius{
    [self setCornerRadius:radius borderWidth:0 borderColor:nil];
}

-(void)setCornerRadius:(CGFloat)radius borderWidth:(CGFloat)borderWidth borderColor:(UIColor*)borderColor {
    CGRect rect = self.bounds;
    
    CGSize radio = CGSizeMake(radius, radius);//圆角尺寸
    
    UIRectCorner corner = UIRectCornerAllCorners;//圆角位置
    
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:rect byRoundingCorners:corner cornerRadii:radio];
    
    CAShapeLayer *masklayer = [[CAShapeLayer alloc]init];//创建shapelayer
    
    masklayer.frame = self.bounds;
    
    masklayer.path = path.CGPath;//设置路径
    
    self.layer.mask = masklayer;
    if (borderWidth == 0) {
        return;
    }
    CAShapeLayer *boardLayer = [[CAShapeLayer alloc] init];
    boardLayer.path = path.CGPath;//设置路径
    boardLayer.lineWidth = borderWidth;
    boardLayer.strokeColor = borderColor.CGColor;
    boardLayer.fillColor = nil;
    [self.layer addSublayer:boardLayer];
}


@end
