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


// MARK: initializer
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

// MARK: for lock image befor read
- (void)showLock:(BOOL)isShown
{
    UIButton* lockView = (UIButton *)[self viewWithTag:0x1234];
    if (isShown == YES && !lockView) {
        lockView = [[UIButton alloc] initWithFrame:self.messageBubbleImageView.frame];
        [lockView setImage:[UIImage imageNamed:@"dbph_lockIcon"] forState:UIControlStateNormal];
        [lockView.imageView setContentMode:UIViewContentModeScaleAspectFit];
        lockView.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleTopMargin |
                                    UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleBottomMargin |
                                    UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        [lockView addTarget:self action:@selector(lockBtnTapped:) forControlEvents:UIControlEventTouchUpInside];
        //[lockView setBackgroundColor:[UIColor greenColor]];
        lockView.tag = 0x1234;
        [self.messageBubbleContainerView addSubview:lockView];
        
    } else if (isShown == NO && lockView) {
        [lockView removeFromSuperview];
    }
    
    [self.textView setHidden:isShown];
}

- (void)lockBtnTapped:(id)sender {
    [self showLock: NO];
    [self startTimer:10];
}


// MARK: for timer
- (void)startTimer:(NSTimeInterval)expiryTime
{
    if (self.timer != NULL) return;
    
    self.timeCount = [NSNumber numberWithDouble:expiryTime];
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(onFire) userInfo:nil repeats:YES];
}

// private messages
- (void)onFire
{
    UIView *view = self;
    do {
        view = view.superview;
    } while (![view isKindOfClass:[UICollectionView class]]);
    UICollectionView *collectionView = (UICollectionView *)view;
    NSIndexPath *indexPath = [collectionView indexPathForCell:self];

    if (indexPath != NULL && [self.timerDelegate respondsToSelector:@selector(timerIntervalAt:)]) {
        NSTimeInterval t = [self.timerDelegate timerIntervalAt:indexPath];
        if (t >= 0) {
            NSString *str = [NSString stringWithFormat:@"%.2ld:%.2ld:%.2ld",(NSInteger)t / 60 / 60, ((NSInteger)t / 60) % 60, (NSInteger)t % 60];
            self.messageBubbleTopLabel.attributedText = [[NSAttributedString alloc] initWithString:str];
            return;
        }
    }
    
    [self.timer invalidate];
    self.timer = NULL;
    [self deleteMsg];

//    double t = self.timeCount.doubleValue;
//    if (t <= 0) {
//        [self.timer invalidate];
//        self.timer = NULL;
//        [self deleteMsg];
//        return;
//    }
//
//    UIView *view = self;
//    do {
//        view = view.superview;
//    } while (![view isKindOfClass:[UICollectionView class]]);
//    UICollectionView *collectionView = (UICollectionView *)view;
//    NSIndexPath *indexPath = [collectionView indexPathForCell:self];
//
//    if (indexPath != NULL && [self.timerDelegate respondsToSelector:@selector(timerStringAt:)]) {
//        self.messageBubbleTopLabel.attributedText = [self.timerDelegate timerStringAt:indexPath];
//
//    }/* else {
//        NSString *str = [NSString stringWithFormat:@"%.2ld:%.2ld:%.2ld",(NSInteger)t / 60 / 60, ((NSInteger)t / 60) % 60, (NSInteger)t % 60];
//        self.messageBubbleTopLabel.attributedText = [[NSAttributedString alloc] initWithString:str];
//    }*/
//
//    self.timeCount = [NSNumber numberWithDouble:(t - 1)];
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
