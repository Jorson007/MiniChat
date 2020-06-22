//
//  KWDBOperate.h
//  AIExercise
//
//  Created by kwni on 2020/6/14.
//  Copyright © 2020 kwni. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <OHMySQL.h>

NS_ASSUME_NONNULL_BEGIN

@interface KWDBOperate : NSObject

-(NSArray *)queryUserInfo;
-(NSArray *)queryMessageInfo;

-(KWDBOperate *)initCoordWithDbName:(NSString *)dbname;

-(BOOL)addMessageItemWithSendId:(NSString *)sendid
                      receiveId:(NSString *)receiveid
                        message:(NSString*)message;

-(BOOL)addUserItemWithUserId:(NSString *)userid
                    userName:(NSString *)username
                    passWord:(NSString*)password;

-(void)disConnect;

@end

NS_ASSUME_NONNULL_END
