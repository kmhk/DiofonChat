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

- (id<JSQMessagesCollectionViewCellTimerDelegate>)timerDelegate
{
    return objc_getAssociatedObject(self, @selector(timerDelegate));
}

- (void)setTimerDelegate:(id<JSQMessagesCollectionViewCellTimerDelegate>)timerDelegate {
    objc_setAssociatedObject(self, @selector(timerDelegate), timerDelegate, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)startTimer:(NSTimeInterval)expiryTime
{
    if (self.timer != NULL) return;
    
    self.timeCount = [NSNumber numberWithDouble:expiryTime];
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(onFire) userInfo:nil repeats:YES];
}

- (void)onFire
{
    double t = self.timeCount.doubleValue;
    if (t < 0) {
        [self.timer invalidate];
        self.timer = NULL;
        [self deleteMsg];
        return;
    }
    
    NSString *str = [NSString stringWithFormat:@"%.2ld:%.2ld:%.2ld",(NSInteger)t / 60 / 60, ((NSInteger)t / 60) % 60, (NSInteger)t % 60];
    self.messageBubbleTopLabel.attributedText = [[NSAttributedString alloc] initWithString:str];
    self.timeCount = [NSNumber numberWithDouble:(t - 1)];
}

- (void)deleteMsg
{
    UIView *view = self;
    do {
        view = view.superview;
    } while (![view isKindOfClass:[UICollectionView class]]);
    UICollectionView *collectionView = (UICollectionView *)view;
    NSIndexPath *indexPath = [collectionView indexPathForCell:self];
    
    if (indexPath != NULL && [self.timerDelegate respondsToSelector:@selector(deleteMessageAt:)]) {
        [self.timerDelegate deleteMessageAt:indexPath];
    }
}

@end
