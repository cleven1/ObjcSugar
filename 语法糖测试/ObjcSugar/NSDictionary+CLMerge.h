//
//  NSDictionary+CLMerge.h
//
//  Created by cleven on 15/1/25.
//  Copyright (c) 2015年 com.apple All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (CLMerge)
/**
 *  @brief  合并两个NSDictionary
 *
 *  @param dict1 NSDictionary
 *  @param dict2 NSDictionary
 *
 *  @return 合并后的NSDictionary
 */
+ (NSDictionary *)cl_dictionaryByMerging:(NSDictionary *)dict1 with:(NSDictionary *)dict2;
/**
 *  @brief  并入一个NSDictionary
 *
 *  @param dict NSDictionary
 *
 *  @return 增加后的NSDictionary
 */
- (NSDictionary *)cl_dictionaryByMergingWith:(NSDictionary *)dict;

#pragma mark - Manipulation
- (NSDictionary *)cl_dictionaryByAddingEntriesFromDictionary:(NSDictionary *)dictionary;
- (NSDictionary *)cl_dictionaryByRemovingEntriesWithKeys:(NSSet *)keys;

@end
