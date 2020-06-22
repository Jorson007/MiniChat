//
//  KWAddViewController.h
//  AIExercise
//
//  Created by kwni on 2020/6/13.
//  Copyright © 2020 kwni. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol AddUserProtocol <NSObject>

-(void)addUserWithUserId:(NSString *)userid
             andUserName:(NSString *)username
             andPassWord:(NSString *)password;

@end

@interface KWRegisterViewController : UIViewController

@property id<AddUserProtocol> delegate;

@end

NS_ASSUME_NONNULL_END
