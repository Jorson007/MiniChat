//
//  KWSettingViewController.m
//  AIExercise
//
//  Created by kwni on 2020/6/14.
//  Copyright © 2020 kwni. All rights reserved.
//

#import "KWSettingViewController.h"
#import "SceneDelegate.h"

@interface KWSettingViewController ()

@end

@implementation KWSettingViewController
{
    NSMutableArray *_arraysection;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"设置";
    _arraysection=[[NSMutableArray alloc]initWithObjects:@"新消息通知",@"隐私",@"通用", nil];
    UITableView *iTable=[[UITableView alloc]initWithFrame:[UIScreen mainScreen].bounds style:UITableViewStyleGrouped];
    
    iTable.sectionHeaderHeight = 20;
    iTable.delegate=self;
    iTable.dataSource=self;
    [self.view addSubview:iTable];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{ //一共有多少个分组
    return 5;
}
 
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{ //每个分组有几行
    if (section==1){
        return 3;
    }else {
        return 1;
    }
}
 
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{   //给各分组设定不同的高度
    return 50;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if(section == 0){
        return 1;
    }else{
        return 10;
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{  //为表格填充内容
    static NSString *identifier=@"identifier";
    
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell==nil) {
        if(indexPath.section == 3 ||indexPath.section == 4){
            cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];//cell的重用机制
        }else{
            cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identifier];//cell的重用机制
        }
    }
    cell.backgroundColor=[UIColor whiteColor];
    if(indexPath.section != 3 && indexPath.section != 4){
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    //依次传值
    if (indexPath.section==0) {
        cell.textLabel.text=@"账号与安全";
    }else if (indexPath.section==1) {
        cell.textLabel.text=[_arraysection objectAtIndex:indexPath.row];//通过数组传递
    }else if (indexPath.section==2){
        cell.textLabel.text=@"关于微信";
        cell.detailTextLabel.text = @"版本7.0.12";
    }else if (indexPath.section==3){
        cell.textLabel.text=@"切换账号";
        cell.textLabel.textAlignment = NSTextAlignmentCenter;
    }else if (indexPath.section==4){
        cell.textLabel.text=@"退出登陆";
        cell.textLabel.textAlignment = NSTextAlignmentCenter;
    }
    return cell;
}
 
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //触发cell响应事件
    if(indexPath.section==4){
        //Action Sheet功能表单
        UIAlertController *action=[UIAlertController alertControllerWithTitle:nil message:@"确认退出?" preferredStyle:UIAlertControllerStyleActionSheet];
        UIAlertAction *exit=[UIAlertAction actionWithTitle:@"退出登录" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
            [self jumpToLogin];  //点击退出登录后，跳转至jumpToLogin方法
        }];
        UIAlertAction *cancel=[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        }];
        [action addAction:exit];  //为该Action Sheet添加exit按键
        [action addAction:cancel];  //为该Action Sheet添加cancel按键
        [self presentViewController:action animated:YES completion:nil]; //在界面上显示
        }else if (indexPath.section==1){
            //依次传值
//        if(indexPath.row==0){
//            SectionViewController *sectionVC = [[SectionViewController alloc] init];
//            sectionVC.titleString = @"我的收藏";  //属性传值方法
//            sectionVC.hidesBottomBarWhenPushed = YES; //隐藏底部的标签栏
//            [self.navigationController pushViewController:sectionVC animated:YES];
//        }else if (indexPath.row==1){
            
//        }else if (indexPath.row==2){
            
//        }else{
            
//        }
//        SectionViewController *sectionVC = [[SectionViewController alloc] init]; //初始化下一界面
//        sectionVC.titleString =[_arraysection objectAtIndex:indexPath.row];//属性传值，通过数组传递
//        sectionVC.hidesBottomBarWhenPushed = YES; //在下一界面隐藏底部的标签栏
//        [self.navigationController pushViewController:sectionVC animated:YES];//跳转至下一界面
    }
    [tableView deselectRowAtIndexPath:indexPath animated:YES]; //取消cell的选中状态
}
 
-(void)jumpToLogin{
   if(@available(iOS 13.0, *)){
        NSArray *array =[[[UIApplication sharedApplication] connectedScenes] allObjects];
        UIWindowScene *windowScene = (UIWindowScene *)array[0];
        SceneDelegate *delegate =(SceneDelegate *)windowScene.delegate;
        [delegate changeToLoginController];
    }
}

@end
