//
//  UIView+frame.h
//  Camdora
//
//  Created by tusm on 2017/2/9.
//  Copyright © 2017年 camdora. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (frame)

@property (assign, nonatomic) CGFloat x;
@property (assign, nonatomic) CGFloat y;
@property (assign, nonatomic) CGFloat w;
@property (assign, nonatomic) CGFloat h;
#pragma mark - 截屏
/// 当前视图内容生成的图像
@property (nonatomic, readonly, nullable)UIImage *cl_capturedImage;


@end
