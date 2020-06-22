//
//  KWUserInfo.h
//  AIExercise
//
//  Created by kwni on 2020/6/14.
//  Copyright © 2020 kwni. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface KWUserInfo : NSObject

@property(strong,nonatomic) NSString* phote;  //头像
@property(strong,nonatomic) NSString* nickName;//名字
@property(strong,nonatomic) NSString* userId; //账号
@property(strong,nonatomic) NSString* passWord; //密码

+(KWUserInfo *)initWithPhoto:(NSString *)photo
                    nickName:(NSString *)nickname
                      userId:(NSString *)userid
                    passWord:(NSString *)password;

@end

NS_ASSUME_NONNULL_END
