//
//  UIDevice+CL.h
//  Camdora
//
//  Created by tusm on 2017/2/11.
//  Copyright © 2017年 camdora. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIDevice (CL)
/**
 *  强制旋转设备
 *  @param  旋转方向
 */
+ (void)setOrientation:(UIInterfaceOrientation)orientation;
@end
