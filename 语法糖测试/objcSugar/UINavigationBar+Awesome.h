//
//  UINavigationBar+Awesome.h
//  LTNavigationBar
//
//  Created by ltebean on 15-2-15.
//  Copyright (c) 2015 ltebean. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UINavigationBar (Awesome)
//背景色
- (void)lt_setBackgroundColor:(UIColor *)backgroundColor;
//透明度
- (void)lt_setElementsAlpha:(CGFloat)alpha;
//Y值
- (void)lt_setTranslationY:(CGFloat)translationY;
//重设
- (void)lt_reset;
@end
