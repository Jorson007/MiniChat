//
//  KWDBOperate.m
//  AIExercise
//
//  Created by kwni on 2020/6/14.
//  Copyright © 2020 kwni. All rights reserved.
//

#import "KWDBOperate.h"
#import <OHMySQL.h>

@implementation KWDBOperate
{
    OHMySQLStoreCoordinator *_coord;
}

-(NSArray *)queryUserInfo{
    OHMySQLQueryContext *context = [OHMySQLQueryContext new];
    context.storeCoordinator = _coord;
    OHMySQLQueryRequest *request = [OHMySQLQueryRequestFactory SELECT:@"userinfo" condition:nil];
    NSError *error = nil;
    NSArray *users = [context executeQueryRequestAndFetchResult:request error:&error];
    if(error == nil){
        return users;
    }else{
        return nil;
    }
    
}

-(NSArray *)queryMessageInfo{
    OHMySQLQueryContext *context = [OHMySQLQueryContext new];
    context.storeCoordinator = _coord;
    OHMySQLQueryRequest *request = [OHMySQLQueryRequestFactory SELECT:@"messageinfo" condition:nil];
    NSError *error = nil;
    NSArray *users = [context executeQueryRequestAndFetchResult:request error:&error];
    if(error == nil){
        return users;
    }else{
        return nil;
    }
    
}

-(BOOL)addMessageItemWithSendId:(NSString *)sendid
                      receiveId:(NSString *)receiveid
                        message:(NSString*)message{
    OHMySQLQueryContext *context = [OHMySQLQueryContext new];
    context.storeCoordinator = _coord;
    NSDate *date = [NSDate now];
    NSDictionary *dict = [[NSDictionary alloc]initWithObjects:@[sendid,receiveid,date,message] forKeys:@[@"sendid",@"receiveid",@"sendtime",@"message"]];
    OHMySQLQueryRequest *request = [OHMySQLQueryRequestFactory INSERT:@"messageinfo" set:dict];
    NSError *error = nil;
    BOOL isSuccess = [context executeQueryRequest:request error:&error];
    return isSuccess;
}

-(BOOL)addUserItemWithUserId:(NSString *)userid
                    userName:(NSString *)username
                    passWord:(NSString*)password{
    OHMySQLQueryContext *context = [OHMySQLQueryContext new];
    context.storeCoordinator = _coord;
    NSDictionary *dict = [[NSDictionary alloc]initWithObjects:@[userid,username,password] forKeys:@[@"userid",@"username",@"password"]];
    OHMySQLQueryRequest *request = [OHMySQLQueryRequestFactory INSERT:@"userinfo" set:dict];
    NSError *error = nil;
    BOOL isSuccess = [context executeQueryRequest:request error:&error];
    return isSuccess;
}
                       

-(KWDBOperate *)initCoordWithDbName:(NSString *)dbname{
    OHMySQLUser *usr = [[OHMySQLUser alloc] initWithUserName:@"root" password:@"19960824" serverName:@"192.168.0.106" dbName:dbname port:3306 socket:nil];
    _coord = [[OHMySQLStoreCoordinator alloc] initWithUser:usr];
    [_coord connect];
    if(_coord.connected){
        return self;
    }else{
        return nil;
    }
    
}

-(void)disConnect{
    [_coord disconnect];
}


@end
