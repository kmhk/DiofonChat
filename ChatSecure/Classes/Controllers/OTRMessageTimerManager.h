//
//  OTRMessageTimerManager.h
//  ChatSecure
//
//  Created by com on 8/12/20.
//  Copyright © 2020 Diomerc Limited. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface OTRMessageTimerManager : NSObject

+ (NSDate *)getUnlockTimerOfMessage:(NSString *)messageID;
+ (void)removeUnlockTimerOfMessage:(NSString *)messageID;
+ (void)setUnlockTimerOfMessage:(NSString *)messageID date:(NSDate *)date;

@end

NS_ASSUME_NONNULL_END
