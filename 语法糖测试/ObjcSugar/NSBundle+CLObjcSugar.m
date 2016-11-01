//
//  NSBundle+CLObjcSugar.m
//  CLObjcSugar
//
//  Created by cleven on 16/3/21.
//  Copyright © 2016年 com.apple. All rights reserved.
//

#import "NSBundle+CLObjcSugar.h"

@implementation NSBundle (CLObjcSugar)

+ (NSString *)cl_currentVersion {
    return [NSBundle mainBundle].infoDictionary[@"CFBundleShortVersionString"];
}

+ (UIImage *)cl_launchImage {
    
    NSArray *launchImages = [NSBundle mainBundle].infoDictionary[@"UILaunchImages"];
    
    NSString *sizeString = NSStringFromCGSize([UIScreen mainScreen].bounds.size);
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"UILaunchImageOrientation = 'Portrait' AND UILaunchImageSize = %@", sizeString];
    NSArray *result = [launchImages filteredArrayUsingPredicate:predicate];
    
    NSString *imageName = result.lastObject[@"UILaunchImageName"];
    
    return [UIImage imageNamed:imageName];
}

- (NSString*)cl_appIconPath {
    NSString* iconFilename = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleIconFile"] ;
    NSString* iconBasename = [iconFilename stringByDeletingPathExtension] ;
    NSString* iconExtension = [iconFilename pathExtension] ;
    return [[NSBundle mainBundle] pathForResource:iconBasename
                                           ofType:iconExtension] ;
}

- (UIImage*)cl_appIcon {
    UIImage*appIcon = [[UIImage alloc] initWithContentsOfFile:[self cl_appIconPath]] ;
    return appIcon;
}

@end
