//
//  CDAStatusBar.m
//  Camdora
//
//  Created by 赵永强 on 2017/8/3.
//  Copyright © 2017年 camdora. All rights reserved.
//

#import "CLStatusBar.h"
#import <objc/runtime.h>

#define CLSuppressPerformSelectorLeakWarning(Stuff) \
do { \
_Pragma("clang diagnostic push") \
_Pragma("clang diagnostic ignored \"-Warc-performSelector-leaks\"") \
Stuff; \
_Pragma("clang diagnostic pop") \
} while (0)

@interface UIImage (CLStatusbarIconColor)

- (UIImage *)cl_imageWithColor:(UIColor *)color;

@end

@implementation UIImage (CLStatusbarIconColor)

- (UIImage *)cl_imageWithColor:(UIColor *)color {
    UIGraphicsBeginImageContextWithOptions(self.size, NO, self.scale);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextTranslateCTM(context, 0, self.size.height);
    CGContextScaleCTM(context, 1.0, -1.0);
    CGContextSetBlendMode(context, kCGBlendModeNormal);
    CGRect rect = CGRectMake(0, 0, self.size.width, self.size.height);
    CGContextClipToMask(context, rect, self.CGImage);
    [color setFill];
    CGContextFillRect(context, rect);
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

@end

id cl_imageHook(id self, SEL _cmd, UIImage *image, UIImage *shadowImage) {
    UIColor *color = objc_getAssociatedObject([CLStatusBar class], @"cl_statusbarIconColor");
    if(color) {
        image = [image cl_imageWithColor:color];
        shadowImage = [shadowImage cl_imageWithColor:color];
    }
    CLSuppressPerformSelectorLeakWarning(
                                          id obj = [self performSelector:NSSelectorFromString(@"cl_imageFromImage:withShadowImage:") withObject:image withObject:shadowImage];
                                          return obj;
                                          );
    
}

id cl__accessoryImage(id self, SEL _cmd) {
    
    UIImage *image;
    CLSuppressPerformSelectorLeakWarning(
                                          image= [self performSelector:NSSelectorFromString(@"cl__accessoryImage")];
                                          );
    
    UIColor *color = objc_getAssociatedObject([CLStatusBar class], @"wel_statusbarIconColor");
    if(color) {
        image = [image cl_imageWithColor:color];
    }
    
    return image;
}

UIColor* cl_tintColor(id self, SEL _cmd) {
    
    UIColor *color = objc_getAssociatedObject([CLStatusBar class], @"cl_statusbarIconColor");
    if (color) {
        return color;
    }
    CLSuppressPerformSelectorLeakWarning (
                                           return [self performSelector:NSSelectorFromString(@"cl_tintColor")];
                                           );
    
}

@implementation CLStatusBar

+(void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        //
        Method  m = class_getClassMethod(NSClassFromString(@"_UILegibilityImageSet"), NSSelectorFromString(@"imageFromImage:withShadowImage:"));
        
        class_addMethod(object_getClass((id)NSClassFromString(@"_UILegibilityImageSet")), NSSelectorFromString(@"cl_imageFromImage:withShadowImage:"), (IMP)cl_imageHook, method_getTypeEncoding(m));
        
        Method m1 = class_getClassMethod(NSClassFromString(@"_UILegibilityImageSet"),NSSelectorFromString(@"imageFromImage:withShadowImage:"));
        Method m2 = class_getClassMethod(NSClassFromString(@"_UILegibilityImageSet"), NSSelectorFromString(@"cl_imageFromImage:withShadowImage:"));
        method_exchangeImplementations(m1,m2);
        
        //
        m = class_getInstanceMethod(NSClassFromString(@"UIStatusBarBatteryItemView"), NSSelectorFromString(@"_accessoryImage"));
        
        class_addMethod(NSClassFromString(@"UIStatusBarBatteryItemView"), NSSelectorFromString(@"cl__accessoryImage"), (IMP)cl__accessoryImage, method_getTypeEncoding(m));
        
        m1 = class_getInstanceMethod(NSClassFromString(@"UIStatusBarBatteryItemView"),NSSelectorFromString(@"_accessoryImage"));
        m2 = class_getInstanceMethod(NSClassFromString(@"UIStatusBarBatteryItemView"), NSSelectorFromString(@"cl__accessoryImage"));
        method_exchangeImplementations(m1,m2);
        
        //
        m = class_getInstanceMethod(NSClassFromString(@"UIStatusBarForegroundStyleAttributes"), NSSelectorFromString(@"tintColor"));
        
        class_addMethod(NSClassFromString(@"UIStatusBarForegroundStyleAttributes"), NSSelectorFromString(@"wel_tintColor"), (IMP)cl_tintColor, method_getTypeEncoding(m));
        
        m1 = class_getInstanceMethod(NSClassFromString(@"UIStatusBarForegroundStyleAttributes"),NSSelectorFromString(@"tintColor"));
        m2 = class_getInstanceMethod(NSClassFromString(@"UIStatusBarForegroundStyleAttributes"), NSSelectorFromString(@"cl_tintColor"));
        method_exchangeImplementations(m1,m2);
        
    });
}

+ (void)updateStatusbarIconColor:(UIColor *)color {
    objc_setAssociatedObject([self class], @"cl_statusbarIconColor", color, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [[UIApplication sharedApplication].keyWindow.rootViewController setNeedsStatusBarAppearanceUpdate];
}


#pragma mark - status hiden
+ (void)setStatusBarHidden:(BOOL)hidden {
    UIView *statusBar = [[[UIApplication sharedApplication] valueForKey:@"statusBarWindow"] valueForKey:@"statusBar"];
    statusBar.hidden = hidden;
}

#pragma mark - 设置tabbar颜色
+ (void)setStatusBarBackgroundColor:(UIColor *)color
{
    UIView *statusBar = [[[UIApplication sharedApplication] valueForKey:@"statusBarWindow"] valueForKey:@"statusBar"];
    
    if ([statusBar respondsToSelector:@selector(setBackgroundColor:)])
    {
        statusBar.backgroundColor = color;
    }
    
}

@end

@interface UIViewController (StatusBarColor)
@end
@interface UINavigationController (StatusBarColor)
@end


@implementation UIViewController (StatusBarColor)

- (UIStatusBarStyle)preferredStatusBarStyle {
    
    NSInteger style = [objc_getAssociatedObject([UIViewController class], @"cl_preferredStatusBarStyle") integerValue];
    
    objc_setAssociatedObject([UIViewController class], @"cl_preferredStatusBarStyle", @(!style), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
    return  style ? 1: 0;
}

@end

@implementation UINavigationController (StatusBarColor)

- (UIViewController *)childViewControllerForStatusBarStyle{
    return self.topViewController;
}

@end
