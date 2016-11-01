//
//  UIView+CLObjcSugar.m
//  CLObjcSugar
//
//  Created by cleven on 16/3/20.
//  Copyright © 2016年 com.apple. All rights reserved.
//

#import "UIView+CLObjcSugar.h"

@implementation UIView (CLObjcSugar)

#pragma mark - Frame
- (CGPoint)cl_viewOrigin {
    return self.frame.origin;
}

- (void)setcl_viewOrigin:(CGPoint)cl_viewOrigin {
    CGRect newFrame = self.frame;
    newFrame.origin = cl_viewOrigin;
    self.frame = newFrame;
}

- (CGSize)cl_viewSize {
    return self.frame.size;
}

- (void)setcl_viewSize:(CGSize)cl_viewSize {
    CGRect newFrame = self.frame;
    newFrame.size = cl_viewSize;
    self.frame = newFrame;
}

#pragma mark - Frame Origin
- (CGFloat)cl_x {
    return self.frame.origin.x;
}

- (void)setcl_x:(CGFloat)cl_x {
    CGRect newFrame = self.frame;
    newFrame.origin.x = cl_x;
    self.frame = newFrame;
}

- (CGFloat)cl_y {
    return self.frame.origin.y;
}

- (void)setcl_y:(CGFloat)cl_y {
    CGRect newFrame = self.frame;
    newFrame.origin.y = cl_y;
    self.frame = newFrame;
}

#pragma mark - Frame Size
- (CGFloat)cl_width {
    return self.frame.size.width;
}

- (void)setcl_width:(CGFloat)cl_width {
    CGRect newFrame = self.frame;
    newFrame.size.width = cl_width;
    self.frame = newFrame;
}

- (CGFloat)cl_height {
    return self.frame.size.height;
}

- (void)setcl_height:(CGFloat)cl_height {
    CGRect newFrame = self.frame;
    newFrame.size.height = cl_height;
    self.frame = newFrame;
}

#pragma mark - 截屏
- (UIImage *)cl_capturedImage {
    
    UIGraphicsBeginImageContextWithOptions(self.bounds.size, YES, 0);
    
    UIImage *result = nil;
    if ([self drawViewHierarchyInRect:self.bounds afterScreenUpdates:YES]) {
        result = UIGraphicsGetImageFromCurrentImageContext();
    }
    
    UIGraphicsEndImageContext();
    
    return result;
}

@end
