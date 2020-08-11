//
//  JSQMessagesCollectionViewCell+Timer.m
//  ChatSecure
//
//  Created by com on 8/10/20.
//  Copyright © 2020 Diomerc Limited. All rights reserved.
//

#import "JSQMessagesCollectionViewCell+Timer.h"
#import <objc/runtime.h>

@implementation JSQMessagesCollectionViewCell (Timer)

- (NSTimer *)timer
{
    return objc_getAssociatedObject(self, @selector(timer));
}

- (void)setTimer:(NSTimer *)timer {
    objc_setAssociatedObject(self, @selector(timer), timer, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSNumber *)timeCount
{
    return objc_getAssociatedObject(self, @selector(timeCount));
}

- (void)setTimeCount:(NSNumber *)timeCount
{
    objc_setAssociatedObject(self, @selector(timeCount), timeCount, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}


- (void)startTimer:(NSInteger)expiryTime
{
    if (self.timer != NULL) return;
    
    self.timeCount = [NSNumber numberWithInteger:expiryTime];
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(onFire) userInfo:nil repeats:YES];
}

- (void)onFire{
    NSInteger t = self.timeCount.integerValue;
    if (t < 0) {
        [self.timer invalidate];
        return;
    }
    
    NSString *str = [NSString stringWithFormat:@"%.2ld:%.2ld", t / 60, t % 60];
    self.messageBubbleTopLabel.attributedText = [[NSAttributedString alloc] initWithString:str];
    self.timeCount = [NSNumber numberWithInteger:(t - 1)];
}

@end
