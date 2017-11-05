//
//  NSString+CDAExtend.h
//  Camdora
//
//  Created by Edwin Cen on 06/03/2017.
//  Copyright © 2017 camdora. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (CDAExtend)

- (BOOL)isLocalURL;
- (int)numberOfOccurrencesOfString: (NSString *)target;
- (NSURL *)url;

//- (NSString *)deviceTypeAbbreviation;

@end
