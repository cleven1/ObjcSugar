//
//  UINavigationController+CLObjcSugar.h
//  CLObjcSugar
//
//  Created by cleven on 16/3/26.
//  Copyright © 2016年 com.apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UINavigationController (CLObjcSugar)

/// 自定义全屏拖拽返回手势
@property (nonatomic, strong, readonly) UIPanGestureRecognizer *cl_popGestureRecognizer;

@end
