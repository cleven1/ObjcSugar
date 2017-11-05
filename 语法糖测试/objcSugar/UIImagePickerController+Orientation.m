//
//  UIImagePickerController+Orientation.m
//  Camdora
//
//  Created by user on 19/9/17.
//  Copyright © 2017年 camdora. All rights reserved.
//

#import "UIImagePickerController+Orientation.h"

@implementation UIImagePickerController (Orientation)

-(BOOL)shouldAutorotate{
    return YES;
}

-(UIInterfaceOrientationMask)supportedInterfaceOrientations{
    return UIInterfaceOrientationMaskPortrait | UIInterfaceOrientationMaskPortraitUpsideDown;
}

@end
