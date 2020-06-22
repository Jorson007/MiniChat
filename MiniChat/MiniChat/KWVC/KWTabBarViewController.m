//
//  KWTabBarViewController.m
//  AIExercise
//
//  Created by kwni on 2020/6/13.
//  Copyright © 2020 kwni. All rights reserved.
//

#import "KWTabBarViewController.h"
#import "KWFirstViewController.h"
#import "KWSecondViewController.h"
#import "KWThirdViewController.h"
#import "KWFourthViewController.h"

@interface KWTabBarViewController ()

@end

@implementation KWTabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
     self.view.backgroundColor=[UIColor whiteColor];
       
    KWFirstViewController *homePage=[[KWFirstViewController alloc]init];
    homePage.tabBarItem.title=@"首页";     //设置标题
    homePage.tabBarItem.image=[UIImage imageNamed: @"xinxi.png"];   //设置图片
    UINavigationController *firstNav = [[UINavigationController alloc] initWithRootViewController:homePage];       //navigation容器
    [self addChildViewController:firstNav];       //将该页面加入到TabBar容器中

    KWSecondViewController *friends=[[KWSecondViewController alloc]init];
    friends.tabBarItem.title=@"通讯录";
    friends.tabBarItem.image=[UIImage imageNamed:@"tongxunlu.png"];
    UINavigationController *friendsNav=[[UINavigationController alloc]initWithRootViewController:friends];
    [self addChildViewController:friendsNav];

    KWThirdViewController *find=[[KWThirdViewController alloc]init];
    find.tabBarItem.title=@"发现";
    find.tabBarItem.image=[UIImage imageNamed:@"faxian.png"];
    UINavigationController *findNav=[[UINavigationController alloc]initWithRootViewController:find];
    [self addChildViewController:findNav];
        
    KWFourthViewController *i=[[KWFourthViewController alloc]init];
    i.tabBarItem.title=@"我";
    i.tabBarItem.image=[UIImage imageNamed:@"wode.png"];
    UINavigationController *iNav=[[UINavigationController alloc]initWithRootViewController:i];
    [self addChildViewController:iNav];
}



@end
