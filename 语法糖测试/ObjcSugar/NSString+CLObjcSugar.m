//
//  NSString+CLObjcSugar.m
//  CLObjcSugar
//
//  Created by cleven on 16/3/21.
//  Copyright © 2016年 com.apple. All rights reserved.
//

#import "NSString+CLObjcSugar.h"

@implementation NSString (CLPath)

- (NSString *)cl_documentDirectory {
    return [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject stringByAppendingPathComponent:self];
}

- (NSString *)cl_cacheDirecotry {
    return [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES).firstObject stringByAppendingPathComponent:self];
}

- (NSString *)cl_tmpDirectory {
    return [NSTemporaryDirectory() stringByAppendingPathComponent:self];
}

@end

@implementation NSString (CLBase64)

- (NSString *)cl_base64encode {
    NSData *data = [self dataUsingEncoding:NSUTF8StringEncoding];
    
    return [data base64EncodedStringWithOptions:0];
}

- (NSString *)cl_base64decode {
    NSData *data = [[NSData alloc] initWithBase64EncodedString:self options:0];
    
    return [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
}

@end
