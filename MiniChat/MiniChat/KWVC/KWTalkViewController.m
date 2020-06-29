//
//  KWTalkViewController.m
//  MiniChat
//
//  Created by kwni on 2020/6/21.
//  Copyright © 2020 kwni. All rights reserved.
//

#import "KWTalkViewController.h"
#import "KWSocketManager.h"
#import "KWTableViewController.h"
#import "KWMessageModel.h"
#import "KWRightMessageFrameModel.h"

@interface KWTalkViewController ()

@property (nonatomic,strong) NSMutableArray *dataArray;
@property (strong, nonatomic) IBOutlet UITextField *message;
@property (strong, nonatomic) IBOutlet UIImageView *send;
@property (strong, nonatomic) IBOutlet UIImageView *emoj;
@property (strong, nonatomic) IBOutlet UIView *bottomview;

@property (strong, nonatomic) KWTableViewController *tableVC;

@end

@implementation KWTalkViewController


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];

}




- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _tableVC = [[KWTableViewController alloc] init];
    [_tableVC.view setFrame:CGRectMake(self.view.frame.origin.x, self.view.frame.origin.y, self.view.frame.size.width, self.view.frame.size.height-60)];
//    tableVC.view.backgroundColor = [UIColor redColor];
    
    [self addChildViewController:_tableVC];
    
    [self.view addSubview:_tableVC.view];
    
    _bottomview = [[UIView alloc] initWithFrame:CGRectMake(self.view.frame.origin.x, self.view.frame.size.height-60, self.view.frame.size.width, 60)];
    _bottomview.backgroundColor = [UIColor colorWithRed:0.92 green:0.92 blue:0.92 alpha:1];
    [self.view addSubview:_bottomview];
    
    _message=[[UITextField alloc]init];
    _message.frame=CGRectMake(self.view.frame.origin.x+10, self.view.frame.size.height-56, self.view.frame.size.width-120, 52);
    _message.borderStyle = UITextBorderStyleRoundedRect;
    _message.backgroundColor = [UIColor whiteColor];
    _message.layer.cornerRadius=5;
    [self.view addSubview:_message];
    
    _send = [[UIImageView alloc] initWithFrame:CGRectMake(self.view.frame.size.width-60, self.view.frame.size.height-56, 50, 52)];
    //initWithFrame控制位置和尺寸
    _send.image = [UIImage imageNamed:@"fasong.png"];
    _send.userInteractionEnabled = YES;//打开用户交互
    //初始化一个手势
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(senMessageAction:)];
    //为图片添加手势
    [_send addGestureRecognizer:singleTap];

    
    [self.view addSubview:_send];
    
    _emoj = [[UIImageView alloc] initWithFrame:CGRectMake(self.view.frame.size.width-105, self.view.frame.size.height-52, 40, 40)];
    //initWithFrame控制位置和尺寸
    _emoj.image = [UIImage imageNamed:@"biaoqing1.png"];
    
    
    [self.view addSubview:_emoj];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(transformView:) name:UIKeyboardWillChangeFrameNotification object:nil];
    
    [[KWSocketManager share] connect];
}

-(void)transformView:(NSNotification *)notification{
    NSValue *begin = [[notification userInfo]objectForKey:UIKeyboardFrameBeginUserInfoKey];
    CGRect beginRect = [begin CGRectValue];
    
    NSValue *after = [[notification userInfo]objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGRect afterRect = [after CGRectValue];
    
    CGFloat deltaY = afterRect.origin.y - beginRect.origin.y;
    [UIView animateWithDuration:0.25f animations:^{
        [self->_message setFrame:CGRectMake(self->_message.frame.origin.x, self->_message.frame.origin.y+deltaY, self->_message.frame.size.width, self->_message.frame.size.height)];
        [self->_bottomview setFrame:CGRectMake(self->_bottomview.frame.origin.x, self->_bottomview.frame.origin.y+deltaY, self->_bottomview.frame.size.width, self->_bottomview.frame.size.height)];
        [self->_send setFrame:CGRectMake(self->_send.frame.origin.x, self->_send.frame.origin.y + deltaY, self->_send.frame.size.width, self->_send.frame.size.height)];
        [self->_emoj setFrame:CGRectMake(self->_emoj.frame.origin.x, self->_emoj.frame.origin.y+deltaY, self->_emoj.frame.size.width, self->_emoj.frame.size.height)];
    }];
    

}


- (void)viewWillDisappear:(BOOL)animated{
    [[KWSocketManager share] disConnect];

}
#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

//    CellChatList *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([CellChatList class])];
//    if (indexPath.row < self.dataArray.count) {
//        cell.model         = self.dataArray[indexPath.row];
//        cell.touchDelegate = self;
//    }
//    return cell;
    return nil;
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{

    return 60.0f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
//    YHChatDetailVC *vc = [[YHChatDetailVC alloc] init];
//    vc.model = self.dataArray[indexPath.row];
//    vc.hidesBottomBarWhenPushed = YES;
//    [self.navigationController pushViewController:vc animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)senMessageAction:(UIGestureRecognizer *)gestureRecognizer{
     //do something....
    if (_message.text.length == 0) {
        return;
    }
//    NSMutableArray *messages = _tableVC.KWInfoArray;
    NSDictionary *dict = @{@"name" : _message.text, @"icon" : @"girl.png", @"text" : @""};
    KWMessageModel *model = [KWMessageModel modelWithDict:dict];
    KWRightMessageFrameModel *frameModel = [[KWRightMessageFrameModel alloc] init];
    frameModel.model = model;
    [_tableVC.KWInfoArray addObject:frameModel];
    [_tableVC.tableView reloadData];
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
