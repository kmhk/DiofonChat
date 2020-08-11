//
//  JSQMessagesCollectionViewCell+Timer.h
//  ChatSecure
//
//  Created by com on 8/10/20.
//  Copyright © 2020 Diomerc Limited. All rights reserved.
//

#import "JSQMessagesCollectionViewCell.h"

NS_ASSUME_NONNULL_BEGIN

@interface JSQMessagesCollectionViewCell (Timer)

- (void)startTimer:(NSInteger)expiryTime;

@property (strong, nonatomic) NSTimer *timer;
@property (strong, nonatomic) NSNumber *timeCount;

@end

NS_ASSUME_NONNULL_END
