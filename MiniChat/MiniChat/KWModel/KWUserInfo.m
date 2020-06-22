//
//  KWUserInfo.m
//  AIExercise
//
//  Created by kwni on 2020/6/14.
//  Copyright © 2020 kwni. All rights reserved.
//

#import "KWUserInfo.h"

@implementation KWUserInfo

+(KWUserInfo *)initWithPhoto:(NSString *)photo
                    nickName:(NSString *)nickname
                      userId:(NSString *)userid
                    passWord:(NSString *)password{
    KWUserInfo *user = [[KWUserInfo alloc]init];
    user.nickName = nickname;
    user.phote = photo;
    user.userId = userid;
    user.passWord = password;
    return user;
}

@end
