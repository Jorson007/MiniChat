//
//  KWSecondViewController.m
//  AIExercise
//
//  Created by kwni on 2020/6/13.
//  Copyright © 2020 kwni. All rights reserved.
//

#import "KWSecondViewController.h"
#import "KWUserInfo.h"
#import "KWDBOperate.h"

@interface KWSecondViewController ()


@end

@implementation KWSecondViewController
{
     NSMutableArray *_userArr;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"联系人";
    KWDBOperate *operate = [[KWDBOperate alloc] initCoordWithDbName:@"wechat"];
    if(operate != nil){
        NSArray *users = [operate queryUserInfo];
        _userArr = [[NSMutableArray alloc] init];
        for(NSInteger i=0;i<users.count;i++){
            NSString *username = [users[i] objectForKey:@"username"];
            NSString *password = [users[i] objectForKey:@"password"];
            NSString *userid = [users[i] objectForKey:@"userid"];
            NSString *photo = [users[i] objectForKey:@"photo"];
            if([photo isEqual:[NSNull null]] || [photo isEqualToString:@""]){
                photo = @"touxiang.png";
            }
            KWUserInfo *user = [KWUserInfo initWithPhoto:photo nickName:username userId:userid passWord:password];
            [_userArr addObject:user];
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
    return _userArr.count;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier = @"identifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if(cell==nil){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier];
    }
    KWUserInfo *user = [_userArr objectAtIndex:indexPath.row];
    cell.imageView.image = [UIImage imageNamed:user.phote];
    cell.textLabel.text = user.nickName;
//    cell.detailTextLabel.text = user.data;
    return cell;
        
    
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
