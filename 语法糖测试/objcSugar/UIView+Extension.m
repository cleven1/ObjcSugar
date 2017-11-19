//
//  UIView+Extension.m
//

#import "UIView+Extension.h"

@implementation UIView (Extension)

- (void)disableAWhile {
    [self disableAWhile:0];
}

- (void)disableAWhile:(NSTimeInterval)time {
    
    self.userInteractionEnabled = NO;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(time > 0 ? time : 1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        self.userInteractionEnabled = YES;
    });
}

@end
