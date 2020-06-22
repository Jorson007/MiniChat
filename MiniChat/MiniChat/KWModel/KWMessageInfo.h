//
//  KWMessageInfo.h
//  AIExercise
//
//  Created by kwni on 2020/6/14.
//  Copyright © 2020 kwni. All rights reserved.
//

#import <Foundation/Foundation.h>


NS_ASSUME_NONNULL_BEGIN

@interface KWMessageInfo : NSObject


@property(strong,nonatomic) NSString* sendId;
@property(strong,nonatomic) NSString* receiveId;
@property(strong,nonatomic) NSString* sendUserName;
@property(strong,nonatomic) NSString* receiveUserName;
@property(strong,nonatomic) NSDate* sendTime;
@property(strong,nonatomic) NSString* message;

+(KWMessageInfo *)initWithMessage:(NSString *)message
                           sendId:(NSString *)sendid
                     sendUserName:(NSString *)sendusername
                        receiveId:(NSString *)receiveid
                  receiveUserName:(NSString *)receiveusername
                         sendTime:(NSString *)sendtime;

@end

NS_ASSUME_NONNULL_END
