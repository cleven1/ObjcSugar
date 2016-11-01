//
//  NSBundle+CLObjcSugar.h
//  CLObjcSugar
//
//  Created by cleven on 16/3/21.
//  Copyright © 2016年 com.apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NSBundle (CLObjcSugar)

/// 当前版本号字符串
+ (nullable NSString *)cl_currentVersion;

/// 与当前屏幕尺寸匹配的启动图像
+ (nullable UIImage *)cl_launchImage;



///  appicon路径
- (nullable NSString *)cl_appIconPath;

///  appIconImage
- (nullable UIImage *)cl_appIcon;

@end
