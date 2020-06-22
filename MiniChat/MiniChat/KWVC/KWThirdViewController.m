//
//  KWThirdViewController.m
//  AIExercise
//
//  Created by kwni on 2020/6/13.
//  Copyright © 2020 kwni. All rights reserved.
//

#import "KWThirdViewController.h"
#import "SceneDelegate.h"

@interface KWThirdViewController ()

@end

@implementation KWThirdViewController
{
    NSMutableArray *_arraysection;
    NSMutableArray *_arraysectionpic;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"发现";
    NSMutableArray *arraysection1 =[[NSMutableArray alloc]initWithObjects:@"朋友圈",nil];
    NSMutableArray *arraysection2 =[[NSMutableArray alloc]initWithObjects:@"扫一扫",@"摇一摇", nil];
    NSMutableArray *arraysection3 =[[NSMutableArray alloc]initWithObjects:@"看一看",@"搜一搜", nil];
    NSMutableArray *arraysection4 =[[NSMutableArray alloc]initWithObjects:@"附近的人", nil];
    NSMutableArray *arraysection5 =[[NSMutableArray alloc]initWithObjects:@"购物",@"游戏", nil];
    NSMutableArray *arraysection6 =[[NSMutableArray alloc]initWithObjects:@"小程序",nil];
    
    NSMutableArray *arraysectionpic1 =[[NSMutableArray alloc]initWithObjects:@"pengyouquan.png",nil];
    NSMutableArray *arraysectionpic2 =[[NSMutableArray alloc]initWithObjects:@"saoyisao.png",@"yaoyiyao.png", nil];
    NSMutableArray *arraysectionpic3 =[[NSMutableArray alloc]initWithObjects:@"kanyikan.png",@"souyisou.png", nil];
    NSMutableArray *arraysectionpic4 =[[NSMutableArray alloc]initWithObjects:@"fujinderen.png", nil];
    NSMutableArray *arraysectionpic5 =[[NSMutableArray alloc]initWithObjects:@"shopping-bag.png",@"youxi.png", nil];
    NSMutableArray *arraysectionpic6 =[[NSMutableArray alloc]initWithObjects:@"xiaochengxu.png",nil];
    
    _arraysection = [[NSMutableArray alloc] initWithObjects:arraysection1,arraysection2,arraysection3,arraysection4,arraysection5,arraysection6, nil];
    
     _arraysectionpic = [[NSMutableArray alloc] initWithObjects:arraysectionpic1,arraysectionpic2,arraysectionpic3,arraysectionpic4,arraysectionpic5,arraysectionpic6, nil];
    

    UITableView *iTable=[[UITableView alloc]initWithFrame:[UIScreen mainScreen].bounds style:UITableViewStyleGrouped];
    
    iTable.sectionHeaderHeight = 10;
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
    return 6;
}
 
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{ //每个分组有几行
    if (section==1 || section==2|| section==4){
        return 2;
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
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier];//cell的重用机制
    }
    cell.backgroundColor=[UIColor whiteColor];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    //依次给各cell赋值
    cell.textLabel.text=[[_arraysection objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];//通过数组传递
    
    cell.imageView.image = [UIImage imageNamed:[[_arraysectionpic objectAtIndex:indexPath.section] objectAtIndex:indexPath.row]];
//    cell.imageView.image=[UIImage imageNamed:[section2PicArr objectAtIndex:indexPath.row]];
    
//    //依次传值
//    if (indexPath.section==0) {
//        cell.imageView.image=[UIImage imageNamed:@"touxiang.png"];
//        cell.textLabel.text=@"nikwei";
//        cell.detailTextLabel.text = @"微信号:nkw2219479711";
//    }else if (indexPath.section==3) {
//        cell.imageView.image=[UIImage imageNamed:@"zhifu-2.png"];
//        cell.textLabel.text=@"支付";
//    }else if (indexPath.section==1) {
//        cell.imageView.image=[UIImage imageNamed:@"zhifu-2.png"];
//        cell.textLabel.text=@"支付";
//    }else if (indexPath.section==2){
//        //依次给各cell赋值
//        cell.textLabel.text=[_arraysection1 objectAtIndex:indexPath.row];//通过数组传递
//        cell.imageView.image=[UIImage imageNamed:[section2PicArr objectAtIndex:indexPath.row]];
//    }else{
//        cell.imageView.image=[UIImage imageNamed:@"shezhi.png"];
//        cell.textLabel.text=@"设置";
//    }
    return cell;
}
 
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //触发cell响应事件
    if(indexPath.section==2){
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
