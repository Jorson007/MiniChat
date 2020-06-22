//
//  SceneDelegate.h
//  AIExercise
//
//  Created by kwni on 2020/6/13.
//  Copyright © 2020 kwni. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SceneDelegate : UIResponder <UIWindowSceneDelegate>

@property (strong, nonatomic) UIWindow * window;
-(void)changeToTabbarController;//登陆切换到tabbar
-(void)changeToLoginController;//tabbarx切换到登陆
-(void)changeToSettingController;//tabbarx切换到登陆

@end

