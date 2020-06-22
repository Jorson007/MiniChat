//
//  KWAddViewController.m
//  AIExercise
//
//  Created by kwni on 2020/6/13.
//  Copyright © 2020 kwni. All rights reserved.
//

#import "KWRegisterViewController.h"
#import "KWToastView.h"

@interface KWRegisterViewController ()

@property (strong, nonatomic) IBOutlet UITextField *userid;  //用户id,手机号
@property (strong, nonatomic) IBOutlet UITextField *username; //用户名
@property (strong, nonatomic) IBOutlet UITextField *password;  //密码

@end

@implementation KWRegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UILabel *tipLabel=[[UILabel alloc]initWithFrame:CGRectMake(20, 90, 200, 50)];
    tipLabel.text=@"用户注册";
    tipLabel.highlighted = YES;
    tipLabel.font = [UIFont systemFontOfSize:20];
    [self.view addSubview:tipLabel];
    
    _userid=[[UITextField alloc]init];
    _userid.frame=CGRectMake(20, 160, 400, 60);
    _userid.borderStyle = UITextBorderStyleNone;
    _userid.placeholder = @"请输入手机号";
    [self.view addSubview:_userid];
    
    UIView *horizontalLine1 = [[UIView alloc]initWithFrame:CGRectMake(10, 220, 400, 1)];
    horizontalLine1.backgroundColor = [UIColor colorWithRed:0.8 green:0.8 blue:0.8 alpha:0.5];
    [self.view addSubview:horizontalLine1];
    
    _username=[[UITextField alloc]init];
    _username.frame=CGRectMake(20, 260, 400, 60);
    _username.borderStyle = UITextBorderStyleNone;
    _username.placeholder = @"请输入用户名";
    [self.view addSubview:_username];
    
    UIView *horizontalLine2 = [[UIView alloc]initWithFrame:CGRectMake(10, 320, 400, 1)];
    horizontalLine2.backgroundColor = [UIColor colorWithRed:0.8 green:0.8 blue:0.8 alpha:0.5];
    [self.view addSubview:horizontalLine2];
    
    _password=[[UITextField alloc]init];
    _password.frame=CGRectMake(20, 360, 400, 60);
    _password.secureTextEntry=YES;  //输入的字符变成*号
    _password.placeholder = @"请输入密码";
    _password.clearButtonMode=UITextFieldViewModeAlways;  //有“X”键可以清空文本
    [self.view addSubview:_password];
    
    UIView *horizontalLine3 = [[UIView alloc]initWithFrame:CGRectMake(10, 420, 400, 1)];
    horizontalLine3.backgroundColor = [UIColor colorWithRed:0.8 green:0.8 blue:0.8 alpha:0.5];
    [self.view addSubview:horizontalLine3];
    
    UIButton *but=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    but.frame=CGRectMake(140, 550, 120, 50);
    [but setTitle:@"注册" forState:UIControlStateNormal];
    [but addTarget:self action:@selector(submitRegister) forControlEvents:UIControlEventTouchUpInside];
    but.layer.cornerRadius = 20.0; //按键跳转事件，self指代自身。selector（）里面写的是跳转方法,即跳转到jumpToNext()方法。监听“点击事件”，所以是UIControlEventTouchUpInside
    [but setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    
    but.backgroundColor=[UIColor colorWithRed:0.15 green:0.5 blue:0.95 alpha:1];
    //alpha：透明度
    but.titleLabel.font=[UIFont systemFontOfSize:20];//设置按键的字体大小
    
    
    [self.view addSubview:but];
    
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

-(void)submitRegister{
    //此处需要做异常判断
    if([_userid.text isEqualToString:@""] || [_password.text isEqualToString:@""]||[_username.text isEqualToString:@""]){
        [[KWToastView shareInstance] showMessage:@"请确认账号、密码和用户名是否为空!" duration:2];
        return;
    }
    [self.delegate addUserWithUserId:self.userid.text andUserName:self.username.text andPassWord:self.password.text];
    [self.navigationController popViewControllerAnimated:YES];

    
}

@end
