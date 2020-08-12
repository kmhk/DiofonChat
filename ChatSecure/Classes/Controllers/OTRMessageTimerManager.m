//
//  OTRMessageTimerManager.m
//  ChatSecure
//
//  Created by com on 8/12/20.
//  Copyright © 2020 Diomerc Limited. All rights reserved.
//

#import "OTRMessageTimerManager.h"

@implementation OTRMessageTimerManager

+ (NSDate *)getUnlockTimerOfMessage:(NSString *)messageID
{
    NSDictionary *dict = (NSDictionary *)[[NSUserDefaults standardUserDefaults] objectForKey:@"messageUnlockTimer"];
    if (dict) {
        return [dict objectForKey:messageID];
    }
    
    return NULL;
}


+ (void)removeUnlockTimerOfMessage:(NSString *)messageID
{
    NSDictionary *dict = (NSDictionary *)[[NSUserDefaults standardUserDefaults] objectForKey:@"messageUnlockTimer"];
    NSMutableDictionary *mutableDict;
    
    if (dict) {
        mutableDict = [NSMutableDictionary dictionaryWithDictionary:dict];
    } else {
        mutableDict = [[NSMutableDictionary alloc] init];
    }

    [mutableDict removeObjectForKey:messageID];
    
    [[NSUserDefaults standardUserDefaults] setObject:mutableDict forKey:@"messageUnlockTimer"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}


+ (void)setUnlockTimerOfMessage:(NSString *)messageID date:(NSDate *)date
{
    NSDictionary *dict = (NSDictionary *)[[NSUserDefaults standardUserDefaults] objectForKey:@"messageUnlockTimer"];
    NSMutableDictionary *mutableDict;
    
    if (dict) {
        mutableDict = [NSMutableDictionary dictionaryWithDictionary:dict];
    } else {
        mutableDict = [[NSMutableDictionary alloc] init];
    }
    
    [mutableDict setObject:date forKey:messageID];
    
    [[NSUserDefaults standardUserDefaults] setObject:mutableDict forKey:@"messageUnlockTimer"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

@end
