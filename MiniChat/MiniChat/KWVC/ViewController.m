//
//  ViewController.m
//  AIExercise
//  用户登陆之后的viewcontroller
//  Created by kwni on 2020/6/13.
//  Copyright © 2020 kwni. All rights reserved.
//

#import "ViewController.h"
#import "SceneDelegate.h"
#import "AppDelegate.h"
#import "KWDBOperate.h"
#import "KWToastView.h"


@interface ViewController ()

@property (strong, nonatomic) IBOutlet UITextField *username;
@property (strong, nonatomic) IBOutlet UITextField *password;

@property (strong, nonatomic) IBOutlet UILabel *fogetPassword;
@property (strong, nonatomic) IBOutlet UILabel *registerUser;

@property (strong, nonatomic) KWRegisterViewController *registerVC;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"登录";
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/2-50, 150, 100, 100)];
    //initWithFrame控制位置和尺寸
    imageView.image = [UIImage imageNamed:@"denglu.png"];
    [self.view addSubview:imageView];
    //把imageView加到视图中
    
    UILabel *userLabel=[[UILabel alloc]initWithFrame:CGRectMake(50, 320, 90, 50)];
    userLabel.text=@"用户名：";
    [self.view addSubview:userLabel];
    
    _username=[[UITextField alloc]init];
    _username.frame=CGRectMake(120, 325, 210, 40);
    _username.borderStyle = UITextBorderStyleRoundedRect;
    _username.layer.borderColor=[UIColor brownColor].CGColor;
    _username.layer.borderWidth=1;
    _username.layer.cornerRadius=5;
    [self.view addSubview:_username];
    
    UILabel *passLabel=[[UILabel alloc]initWithFrame:CGRectMake(50, 390, 90, 50)];
    passLabel.text=@"密   码：";
    [self.view addSubview:passLabel];
    
    _password=[[UITextField alloc]init];
    _password.frame=CGRectMake(120, 395, 210, 40);
    _password.borderStyle = UITextBorderStyleRoundedRect;
    _password.secureTextEntry=YES;  //输入的字符变成*号
    _password.clearButtonMode=UITextFieldViewModeAlways;  //有“X”键可以清空文本
    _password.layer.borderColor=[UIColor brownColor].CGColor;
    _password.layer.borderWidth=1;
    _password.layer.cornerRadius=5;
    [self.view addSubview:_password];
    
    UIButton *but=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    but.frame=CGRectMake(SCREEN_WIDTH/2-40, 490, 80, 80);
    [but setImage:[UIImage imageNamed:@"next.png"] forState:UIControlStateNormal];
    [but addTarget:self action:@selector(jumpToNext) forControlEvents:UIControlEventTouchUpInside];
    //按键跳转事件，self指代自身。selector（）里面写的是跳转方法,即跳转到jumpToNext()方法。监听“点击事件”，所以是UIControlEventTouchUpInside
    [but setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.view addSubview:but];
    
    _fogetPassword =[[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/2-100, 640, 90, 50)];
    _fogetPassword.text=@"忘记密码";
    [self.view addSubview:_fogetPassword];
    _fogetPassword.userInteractionEnabled=YES;
    //创建点击事件，点击的时候触发touchAble
    UITapGestureRecognizer *rec = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(forgetPassword:)];
    //添加点击事件
    [_fogetPassword addGestureRecognizer:rec];

    _registerUser =[[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/2+10, 640, 90, 50)];
    _registerUser.text=@"用户注册";
    [self.view addSubview:_registerUser];
    _registerUser.userInteractionEnabled=YES;
    //创建点击事件，点击的时候触发touchAble
    UITapGestureRecognizer *rec1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(registerNewUser:)];
    //添加点击事件
    [_registerUser addGestureRecognizer:rec1];
}

//点击登陆按钮跳转事件
-(void)jumpToNext{
    if([_username.text isEqualToString:@""] || [_password.text isEqualToString:@""]){
         [[KWToastView shareInstance] showMessage:@"账号和密码不能为空" duration:2];
         return;
    }
    KWDBOperate *operate = [[KWDBOperate alloc] initCoordWithDbName:@"wechat"];
    BOOL canGo = false;
    if(operate != nil){
       NSArray *users = [operate queryUserInfo];
       if(users.count == 0){
           NSLog(@"null user");
           return;
       }else{
           for(NSInteger i=0;i<users.count;i++){
               NSString *username = [users[i] objectForKey:@"username"];
               NSString *password = [users[i] objectForKey:@"password"];
               if([username isEqualToString:_username.text] &&[password isEqualToString:_password.text]){
                   canGo = true;
                   break;
               }
           }
       }
       [operate disConnect];
        if(@available(iOS 13.0, *)){
            if(canGo){
                NSArray *array =[[[UIApplication sharedApplication] connectedScenes] allObjects];
                UIWindowScene *windowScene = (UIWindowScene *)array[0];
                SceneDelegate *delegate =(SceneDelegate *)windowScene.delegate;
                [delegate changeToTabbarController];
            }else{
                [[KWToastView shareInstance] showMessage:@"验证失败" duration:2];

            }
        }
    }
}

-(void)forgetPassword:(UITapGestureRecognizer *)rec{
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
    
//    _fogetPassword.layer.shadowColor = [UIColor blackColor].CGColor;
//    _fogetPassword.layer.shadowOffset = CGSizeMake(10, 15);
//    _fogetPassword.layer.shadowOpacity = 0.5;
    
    //通过uiview设置（2D效果）
//    _fogetPassword.transform=CGAffineTransformMakeTranslation(0, -100);
//    //通过layer来设置（3D效果,x，y，z三个方向）
//    _fogetPassword.layer.transform=CATransform3DMakeTranslation(100, 20, 10);
}

-(void)registerNewUser:(UITapGestureRecognizer *)rec{
    _registerVC = [[KWRegisterViewController alloc] init];
    _registerVC.view.backgroundColor = [UIColor whiteColor];
    _registerVC.delegate = self;
    [self.navigationController pushViewController:_registerVC animated:YES];
    self.navigationController.navigationBar.topItem.title = @"";
}

-(void)addUserWithUserId:(NSString *)userid
             andUserName:(NSString *)username
             andPassWord:(NSString *)password{
    self.username.text = username;
    self.password.text = password;
    
    KWDBOperate *operate = [[KWDBOperate alloc] initCoordWithDbName:@"wechat"];
    if(operate != nil){
        BOOL isOk = [operate addUserItemWithUserId:userid userName:username passWord:password];
        if(!isOk){
            NSLog(@"add user failed");
        }
        [operate disConnect];
    }
    
    
}

@end
