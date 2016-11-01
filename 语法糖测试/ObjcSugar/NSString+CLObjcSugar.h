//
//  NSString+CLObjcSugar.h
//  CLObjcSugar
//
//  Created by cleven on 16/3/21.
//  Copyright © 2016年 com.apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (CLPath)

/// 拼接了`文档目录`的全路径
@property (nullable, nonatomic, readonly) NSString *cl_documentDirectory;
/// 拼接了`缓存目录`的全路径
@property (nullable, nonatomic, readonly) NSString *cl_cacheDirecotry;
/// 拼接了临时目录的全路径
@property (nullable, nonatomic, readonly) NSString *cl_tmpDirectory;

@end

@interface NSString (CLBase64)

/// BASE 64 编码的字符串内容
@property(nullable, nonatomic, readonly) NSString *cl_base64encode;
/// BASE 64 解码的字符串内容
@property(nullable, nonatomic, readonly) NSString *cl_base64decode;

@end
