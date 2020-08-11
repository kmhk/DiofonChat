//
//  JSQMessagesCollectionViewCell+Timer.h
//  ChatSecure
//
//  Created by com on 8/10/20.
//  Copyright © 2020 Diomerc Limited. All rights reserved.
//

#import "JSQMessagesCollectionViewCell.h"

NS_ASSUME_NONNULL_BEGIN

@protocol JSQMessagesCollectionViewCellTimerDelegate <NSObject>

- (void)deleteMessageAt:(NSIndexPath *)indexPath;

@end


// MARK: -
@interface JSQMessagesCollectionViewCell (Timer)

- (void)startTimer:(NSTimeInterval)expiryTime;

@property (strong, nullable) NSTimer *timer;
@property (strong, nonatomic) NSNumber *timeCount;
@property (strong, nonatomic) id<JSQMessagesCollectionViewCellTimerDelegate> timerDelegate;

@end

NS_ASSUME_NONNULL_END
