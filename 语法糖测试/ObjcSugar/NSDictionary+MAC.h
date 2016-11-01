//
//  NSDictionary+MAC.h
//
//  Created by cleven on 15/12/21.
//  Copyright © 2015年 com.apple All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary(MAC)
/**
 *  @brief  将url参数转换成NSDictionary
 *
 *  @param query url参数
 *
 *  @return NSDictionary
 */
+ (NSDictionary *)dictionaryWithURLQuery:(NSString *)query;
/**
 *  @brief  将NSDictionary转换成url 参数字符串
 *
 *  @return url 参数字符串
 */
- (NSString *)urlQueryString;
/**
 *  @brief NSDictionary转换成JSON字符串
 *
 *  @return  JSON字符串
 */
-(NSString *)cl_JSONString;
/**
 *  @brief  将NSDictionary转换成XML 字符串
 *
 *  @return XML 字符串
 */
- (NSString *)cl_XMLString;
@end
