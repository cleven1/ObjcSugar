//
//  UINavigationBar+CDACustomHeight.m
//  native
//
//  Created by Edwin Cen on 9/12/16.
//  Copyright © 2016 camdora. All rights reserved.
//

#import "UINavigationBar+CDACustomHeight.h"
#import "objc/runtime.h"

static char const *const heightKey = "Height";

@implementation UINavigationBar (CDACustomHeight)

- (void)setHeight:(CGFloat)height
{
    objc_setAssociatedObject(self, heightKey, @(height), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSNumber *)height
{
    return objc_getAssociatedObject(self, heightKey);
}

- (CGSize)sizeThatFits:(CGSize)size
{
    CGSize newSize;
    
    if (self.height) {
        newSize = CGSizeMake(self.superview.bounds.size.width, [self.height floatValue]);
    } else {
        newSize = [super sizeThatFits:size];
    }
    
    return newSize;
}

@end
