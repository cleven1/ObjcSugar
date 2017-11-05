//
//  NSString+CDAExtend.m
//  Camdora
//
//  Created by Edwin Cen on 06/03/2017.
//  Copyright © 2017 camdora. All rights reserved.
//

#import "NSString+CDAExtend.h"
#import "CDAStringDef.h"

@implementation NSString (CDAExtend)

- (BOOL)isLocalURL
{
    return [self containsString:@"file://"] || ![self containsString:@"http://"];
}

- (int)numberOfOccurrencesOfString: (NSString *)target
{
    NSError *error = NULL;
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:target
                                                                           options:NSRegularExpressionCaseInsensitive
                                                                             error:&error];
    if (error) {
        return -1;
    }
    return (int)[regex numberOfMatchesInString:self options:0 range:NSMakeRange(0, [self length])];
}

- (NSURL *)url
{
    if ([self isLocalURL]) {
        return [NSURL fileURLWithPath:self];
    } else {
        return [NSURL URLWithString:self];
    }
}

//- (NSString *)deviceTypeAbbreviation
//{
//    if ([self isEqualToString:CDA_VIDEO_TYPE_STEREO_FLAT]) {
//        return @"3D";
//    }
//    else if ([self isEqualToString:CDA_VIDEO_TYPE_STEREO_HALF_SPHERE]) {
//        return @"VR3D";
//    }
//    else if ([self isEqualToString:CDA_VIDEO_TYPE_STEREO_SPHERE]) {
//        return @"VR";
//    }
//    else if ([self isEqualToString:CDA_VIDEO_TYPE_NORMAL]) {
//        return @"2D";
//    }
//    else if ([self isEqualToString:CDA_VIDEO_TYPE_PANORAMA]) {
//        return @"Pano";
//    }
//    else {
//        return @"2D";
//    }
//}

@end
