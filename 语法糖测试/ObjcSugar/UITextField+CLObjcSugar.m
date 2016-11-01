//
//  UITextField+CLObjcSugar.m
//  CLObjcSugar
//
//  Created by cleven on 16/3/24.
//  Copyright © 2016年 com.apple. All rights reserved.
//

#import "UITextField+CLObjcSugar.h"

@implementation UITextField (CLObjcSugar)

+ (instancetype)cl_textFieldWithPlaceHolder:(NSString *)placeHolder {

    UITextField *textField = [[self alloc] init];
    
    textField.borderStyle = UITextBorderStyleRoundedRect;
    textField.placeholder = placeHolder;
    
    return textField;
}

@end
