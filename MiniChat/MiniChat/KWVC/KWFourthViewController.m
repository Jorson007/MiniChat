//
//  KWFourthViewController.m
//  AIExercise
//
//  Created by kwni on 2020/6/13.
//  Copyright © 2020 kwni. All rights reserved.
//

#import "KWFourthViewController.h"
#import "SceneDelegate.h"

@interface KWFourthViewController ()

@end

@implementation KWFourthViewController
{
    NSMutableArray *_arraysection;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"我的";
    _arraysection=[[NSMutableArray alloc]initWithObjects:@"收藏",@"相册",@"卡包",@"表情", nil];
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
    return 4;
}
 
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{ //每个分组有几行
    if (section==2){
        return 4;
    }else {
        return 1;
    }
}
 
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{   //给各分组设定不同的高度
    if(indexPath.row==0&&indexPath.section==0){
        //row==0表示第1行，section==0表示第1个分组，与操作，设置第一个分组第一行的高度为80，其余为50
        return 80;
    }else{
        return 50;
    }
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
    NSMutableArray *section2PicArr = [[NSMutableArray alloc] initWithObjects:@"shoucang",@"xiangce",@"kabao",@"biaoqing", nil];
    
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell==nil) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier];//cell的重用机制
    }
    cell.backgroundColor=[UIColor whiteColor];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    //依次传值
    if (indexPath.section==0) {
        cell.imageView.image=[UIImage imageNamed:@"touxiang.png"];
        cell.textLabel.text=@"nikwei";
        cell.detailTextLabel.text = @"微信号:nkw2219479711";
    }else if (indexPath.section==1) {
        cell.imageView.image=[UIImage imageNamed:@"zhifu-2.png"];
        cell.textLabel.text=@"支付";
    }else if (indexPath.section==2){
        //依次给各cell赋值
        cell.textLabel.text=[_arraysection objectAtIndex:indexPath.row];//通过数组传递
        cell.imageView.image=[UIImage imageNamed:[section2PicArr objectAtIndex:indexPath.row]];
    }else{
        cell.imageView.image=[UIImage imageNamed:@"shezhi.png"];
        cell.textLabel.text=@"设置";
    }
    return cell;
}
 
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //点击设置触发cell响应事件
    if(indexPath.section==3){
        //Action Sheet功能表单
        [self jumpToSetting];
        
//        UIAlertController *action=[UIAlertController alertControllerWithTitle:nil message:@"确认退出?" preferredStyle:UIAlertControllerStyleActionSheet];
//        UIAlertAction *exit=[UIAlertAction actionWithTitle:@"退出登录" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
//            [self jumpToLogin];  //点击退出登录后，跳转至jumpToLogin方法
//        }];
//        UIAlertAction *cancel=[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
//        }];
//        [action addAction:exit];  //为该Action Sheet添加exit按键
//        [action addAction:cancel];  //为该Action Sheet添加cancel按键
//        [self presentViewController:action animated:YES completion:nil]; //在界面上显示
//        }else if (indexPath.section==1){
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

-(void)jumpToSetting{
    if(@available(iOS 13.0, *)){
        NSArray *array =[[[UIApplication sharedApplication] connectedScenes] allObjects];
        UIWindowScene *windowScene = (UIWindowScene *)array[0];
        SceneDelegate *delegate =(SceneDelegate *)windowScene.delegate;
        [delegate changeToSettingController];
    }
}

@end
