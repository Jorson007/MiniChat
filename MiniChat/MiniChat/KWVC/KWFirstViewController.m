//
//  KWFirstViewController.m
//  AIExercise
//
//  Created by kwni on 2020/6/13.
//  Copyright © 2020 kwni. All rights reserved.
//

#import "KWFirstViewController.h"
#import "KWMessageInfo.h"
#import "KWDBOperate.h"
#import "KWTalkViewController.h"

@interface KWFirstViewController ()

@end

@implementation KWFirstViewController
{
    NSMutableArray *_messageArr;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"消息";
    KWDBOperate *operate = [[KWDBOperate alloc] initCoordWithDbName:@"wechat"];
    if(operate != nil){
        NSArray *messages = [operate queryMessageInfo];
        _messageArr = [[NSMutableArray alloc] init];
        for(NSInteger i=0;i<messages.count;i++){
            NSString *message = [messages[i] objectForKey:@"message"];
            NSString *sendid = [[messages[i] objectForKey:@"sendid"] stringValue];
            NSString *sendname = [[messages[i] objectForKey:@"sendid"] stringValue];
            NSString *receiveid = [[messages[i] objectForKey:@"receiveid"] stringValue];
            NSString *receivename = [[messages[i] objectForKey:@"receiveid"] stringValue];
            NSString *sendTime = [messages[i] objectForKey:@"sendtime"] ;
            
    
            KWMessageInfo *messageinfo = [KWMessageInfo initWithMessage:message sendId:sendid sendUserName:sendname receiveId:receiveid receiveUserName:receivename sendTime:sendTime];
            [_messageArr addObject:messageinfo];
        }
    }
    
    UITableView *table = [[UITableView alloc] initWithFrame:[UIScreen mainScreen].bounds style:UITableViewStylePlain];
    [table setRowHeight:80];
    [table setSeparatorColor:[UIColor brownColor]];
    UIEdgeInsets inset = table.separatorInset;
    table.separatorInset = UIEdgeInsetsMake(inset.top, 0, inset.bottom, inset.right);
    table.delegate = self;
    table.dataSource = self;
    [self.view addSubview:table];
}



/*
#pragma mark - Navigation
// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _messageArr.count;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    KWTalkViewController *talkVC = [[KWTalkViewController alloc] init];
    talkVC.view.backgroundColor = [UIColor whiteColor];
    talkVC.hidesBottomBarWhenPushed = YES;
    talkVC.title = @"消息";
    [self.navigationController pushViewController:talkVC animated:YES];
    self.navigationController.navigationBar.topItem.title = @"";

}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier = @"identifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if(cell==nil){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier];
    }
    KWMessageInfo *message = [_messageArr objectAtIndex:indexPath.row];
    cell.imageView.image = [UIImage imageNamed:@"xiaoxi.png"];
    cell.textLabel.text = message.sendUserName;
    cell.detailTextLabel.text = message.message;
    return cell;
        
    
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    return YES;
}


- (UISwipeActionsConfiguration *)tableView:(UITableView *)tableView leadingSwipeActionsConfigurationForRowAtIndexPath:(NSIndexPath *)indexPath{
    return nil;
}
- (UISwipeActionsConfiguration *)tableView:(UITableView *)tableView trailingSwipeActionsConfigurationForRowAtIndexPath:(NSIndexPath *)indexPath{
    UIContextualAction *deleteRowAction = [UIContextualAction contextualActionWithStyle:UIContextualActionStyleDestructive title:@"删除" handler:^(UIContextualAction * _Nonnull action, __kindof UIView * _Nonnull sourceView, void (^ _Nonnull completionHandler)(BOOL)) {
            //点击后执行的操作
            completionHandler (YES);
        }];
    UIContextualAction *toTopRowAction = [UIContextualAction contextualActionWithStyle:UIContextualActionStyleDestructive title:@"置顶" handler:^(UIContextualAction * _Nonnull action, __kindof UIView * _Nonnull sourceView, void (^ _Nonnull completionHandler)(BOOL)) {
            //点击后执行的操作
            completionHandler (YES);
    }];
        deleteRowAction.backgroundColor = [UIColor redColor];
        toTopRowAction.backgroundColor = [UIColor blueColor];

        UISwipeActionsConfiguration *config = [UISwipeActionsConfiguration configurationWithActions:@[deleteRowAction,toTopRowAction]];
        return config;
}


@end
