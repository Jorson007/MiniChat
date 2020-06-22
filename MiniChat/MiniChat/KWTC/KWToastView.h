//
//  KWToastView.h
//  AIExercise
//
//  Created by kwni on 2020/6/14.
//  Copyright © 2020 kwni. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface KWAlert : UILabel

- (void) setMessageText:(NSString *)message;   //设置message

@end

@interface KWToastView : NSObject{
    KWAlert *myAlertView;//alertView
    NSTimer *countTimer;
}

+ (instancetype) shareInstance;         //单例 生成alert控制器
- (void) showMessage:(NSString*)text duration:(CGFloat)duration;   //弹出文字

@end

NS_ASSUME_NONNULL_END
