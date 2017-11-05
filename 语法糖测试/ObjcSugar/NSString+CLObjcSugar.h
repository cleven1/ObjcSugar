//
//  NSString+CLObjcSugar.h
//  CLObjcSugar
//
//  Created by cleven on 16/3/21.
//  Copyright © 2016年 com.apple. All rights reserved.
//

#import <UIKit/UIKit.h>

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

@interface NSString (Trims)

/**
 *  @brief  去除空格
 *
 *  @return 去除空格后的字符串
 */
- (nullable NSString *)trimmingWhitespace;

/**
 *  @brief  去除字符串与空行
 *
 *  @return 去除字符串与空行的字符串
 */
- (nullable NSString *)trimmingWhitespaceAndNewlines;

/**
 *  将字符串转化为NSURL
 *
 *  @return  NSURL地址
 */
-(nullable NSURL *)clUrl;
/**
 *  将资源字符串转化为图片资源
 *
 *  @return  图片
 */
-(nullable UIImage *)clImage;


/**
 获得特定字符串的中字符串
 
 @param strLeft: 左边匹配字符串
 
 @param strRight: 右边匹配的字符串
 
 @return NSString类型
 */
- (nonnull NSString*)substringWithinBoundsLeft:(nonnull NSString*)strLeft right:(nonnull NSString*)strRight;


/**
 *  单纯改变一句话中的某些字的颜色（一种颜色）
 *
 *  @param color    需要改变成的颜色
 *  @param totalStr 总的字符串
 *  @param subArray 需要改变颜色的文字数组(要是有相同的 只取第一个)
 *
 *  @return 生成的富文本
 */
-(nonnull NSMutableAttributedString *)cl_changeCorlorWithColor:(nonnull UIColor *)color TotalString:(nonnull NSString *)totalStr SubStringArray:(nonnull NSArray *)subArray;

/**
 *  单纯改变句子的字间距（需要 <CoreText/CoreText.h>）
 *
 *  @param totalString 需要更改的字符串
 *  @param space       字间距
 *
 *  @return 生成的富文本
 */
-(nonnull NSMutableAttributedString *)cl_changeSpaceWithTotalString:(nonnull NSString *)totalString Space:(CGFloat)space;

/**
 *  单纯改变段落的行间距
 *
 *  @param totalString 需要更改的字符串
 *  @param lineSpace   行间距
 *
 *  @return 生成的富文本
 */
-(nonnull NSMutableAttributedString *)cl_changeLineSpaceWithTotalString:(nonnull NSString *)totalString LineSpace:(CGFloat)lineSpace;

/**
 *  同时更改行间距和字间距
 *
 *  @param totalString 需要改变的字符串
 *  @param lineSpace   行间距
 *  @param textSpace   字间距
 *
 *  @return 生成的富文本
 */
-(nonnull NSMutableAttributedString *)cl_changeLineAndTextSpaceWithTotalString:(nonnull NSString *)totalString LineSpace:(CGFloat)lineSpace textSpace:(CGFloat)textSpace;

/**
 *  改变某些文字的颜色 并单独设置其字体
 *
 *  @param font        设置的字体
 *  @param color       颜色
 *  @param totalString 总的字符串
 *  @param subArray    想要变色的字符数组
 *
 *  @return 生成的富文本
 */
-(nonnull NSMutableAttributedString *)cl_changeFontAndColor:(nonnull UIFont *)font Color:(nonnull UIColor *)color TotalString:(nonnull NSString *)totalString SubStringArray:(nonnull NSArray *)subArray;

/**
 *  为某些文字改为链接形式
 *
 *  @param totalString 总的字符串
 *  @param subArray    需要改变颜色的文字数组(要是有相同的 只取第一个)
 *
 *  @return 生成的富文本
 */
-(nonnull NSMutableAttributedString *)cl_addLinkWithTotalString:(nonnull NSString *)totalString SubStringArray:(nonnull NSArray *)subArray;

#pragma mark - 获取某个子字符串在某个总字符串中位置数组
/**
 *  获取某个字符串中子字符串的位置数组
 *
 *  @param totalString 总的字符串
 *  @param subString   子字符串
 *
 *  @return 位置数组
 */
-(nonnull NSMutableArray *)cl_getRangeWithTotalString:(nonnull NSString *)totalString SubString:(nonnull NSString *)subString;
@end
