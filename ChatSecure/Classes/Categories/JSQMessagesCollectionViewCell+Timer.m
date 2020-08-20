//
//  JSQMessagesCollectionViewCell+Timer.m
//  ChatSecure
//
//  Created by com on 8/10/20.
//  Copyright © 2020 Diomerc Limited. All rights reserved.
//

#import "JSQMessagesCollectionViewCell+Timer.h"
#import <objc/runtime.h>
#import <UIColor+JSQMessages.h>

@implementation JSQMessagesCollectionViewCell (Timer)


// MARK: initializer
- (id<JSQMessagesCollectionViewCellTimerDelegate>)timerDelegate
{
    return objc_getAssociatedObject(self, @selector(timerDelegate));
}

- (void)setTimerDelegate:(id<JSQMessagesCollectionViewCellTimerDelegate>)timerDelegate {
    objc_setAssociatedObject(self, @selector(timerDelegate), timerDelegate, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

// MARK: life

- (NSIndexPath *)getIndexPath
{
    UIView *view = self;
    do {
        view = view.superview;
    } while (![view isKindOfClass:[UICollectionView class]]);
    UICollectionView *collectionView = (UICollectionView *)view;
    NSIndexPath *indexPath = [collectionView indexPathForCell:self];
    return indexPath;
}


// MARK: for lock image befor read

- (void)showLock:(BOOL)isShown
{
    UIView *superView;
    CGRect rt;
    UIColor *bkColor;
    if (self.mediaView) {
        superView = self.mediaView;
        rt = self.mediaView.frame;
        bkColor = [UIColor jsq_messageBubbleLightGrayColor];
        
    } else {
        superView = self.messageBubbleContainerView;
        rt = self.messageBubbleContainerView.bounds;
        bkColor = nil;
    }
    
    UIButton* lockView = (UIButton *)[superView viewWithTag:0x1234];
    if (isShown == YES && !lockView) {
        lockView = [[UIButton alloc] initWithFrame:rt];
        [lockView setImage:[UIImage imageNamed:@"dbph_lockIcon"] forState:UIControlStateNormal];
        [lockView.imageView setContentMode:UIViewContentModeScaleAspectFit];
        lockView.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleTopMargin |
                                    UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleBottomMargin |
                                    UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        if (!self.mediaView) [lockView addTarget:self action:@selector(lockBtnTapped:) forControlEvents:UIControlEventTouchUpInside];
        if (bkColor) [lockView setBackgroundColor:bkColor];
        lockView.tag = 0x1234;
        [superView addSubview:lockView];
        
    } else if (isShown == NO && lockView) {
        [lockView removeFromSuperview];
        
    } else if (isShown == YES && lockView) {
        [superView bringSubviewToFront:lockView];
    }
    
    if (self.textView) [self.textView setHidden:isShown];
    //if (self.mediaView) [self.mediaView setHidden:isShown];
}

- (void)lockBtnTapped:(id)sender {
    [self showLock: NO];
    //[self startTimer:10];
    
    NSIndexPath *indexPath = [self getIndexPath];
    if (indexPath != NULL && [self.timerDelegate respondsToSelector:@selector(setUnlockedAt:)]) {
        NSTimeInterval interval = [self.timerDelegate setUnlockedAt:indexPath];
//        [self startTimer:interval];
        
    } /*else { // not sure if it will be call
        [self onFire];
    }*/
}

@end
