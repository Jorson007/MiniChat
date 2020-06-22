//
//  KWToastView.m
//  AIExercise
//
//  Created by kwni on 2020/6/14.
//  Copyright © 2020 kwni. All rights reserved.
//

#import "KWToastView.h"

static int changeCount;

@implementation KWToastView

+ (instancetype) shareInstance{
    static KWToastView *defaultCenter = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        defaultCenter = [[KWToastView alloc] init];
    });
    
    return defaultCenter;
}
-(instancetype)init{
    self = [super init];
    if(self){
        myAlertView = [[KWAlert alloc] init];
        countTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(changeTime) userInfo:nil repeats:YES];
//        countTimer.fireDate = [NSDate distantFuture];//关闭定时器
    }
    return self;
}
 
-(void)showMessage:(NSString *)text duration:(CGFloat)duration{
    if([text length] == 0){
        return;
    }
    [myAlertView setMessageText:text];
    [[[UIApplication sharedApplication] keyWindow] addSubview:myAlertView];
    myAlertView.alpha = 0.8;
    countTimer.fireDate = [NSDate distantPast];  //开启定时器
    changeCount = duration;
}
 
-(void)changeTime{
    if(changeCount-- <= 0){
        countTimer.fireDate = [NSDate distantFuture]; //关闭定时器
        [UIView animateWithDuration:0.2f animations:^{
            myAlertView.alpha = 0;
        } completion:^(BOOL finished){
            [myAlertView removeFromSuperview];
        }];
    }
}

@end

@implementation KWAlert
 

 
-(instancetype)init{
    self = [super init];
    if(self){
        self.layer.cornerRadius = 8;
        self.layer.masksToBounds = YES;
        self.backgroundColor = [UIColor blackColor];
        self.textColor = [UIColor whiteColor];
        self.numberOfLines = 0;
        self.textAlignment = NSTextAlignmentCenter;
        self.font = [UIFont systemFontOfSize:15];
    }
    return self;
}
-(void)setMessageText:(NSString *)message{
    [self setText:message];
    CGRect rect = [self.text boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:self.font} context:nil];
    CGFloat width = rect.size.width + 20;
    CGFloat height = rect.size.height + 20;
    CGFloat x = [[UIApplication sharedApplication] keyWindow].screen.bounds.size.width/2 - width/2;
    CGFloat y = 500;
    self.frame = CGRectMake(x, y, width, height);
}

 

 
 
@end

