//
//  KWMessageInfo.m
//  AIExercise
//
//  Created by kwni on 2020/6/14.
//  Copyright © 2020 kwni. All rights reserved.
//

#import "KWMessageInfo.h"

@implementation KWMessageInfo

+(KWMessageInfo *)initWithMessage:(NSString *)message
                           sendId:(NSString *)sendid
                     sendUserName:(NSString *)sendusername
                        receiveId:(NSString *)receiveid
                  receiveUserName:(NSString *)receiveusername
                         sendTime:(NSString *)sendtime{
    KWMessageInfo *messageInfo = [[KWMessageInfo alloc]init];
    messageInfo.message = message;
    messageInfo.sendId = sendid;
    messageInfo.receiveId = receiveid;
    messageInfo.sendUserName = sendusername;
    messageInfo.receiveUserName = receiveusername;
    
    NSDateFormatter *format = [[NSDateFormatter alloc] init];
    // 设置日期格式 为了转换成功
    format.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    // NSString * -> NSDate *
    NSDate *date = [format dateFromString:sendtime];
    messageInfo.sendTime = date;
    return messageInfo;
}

@end
