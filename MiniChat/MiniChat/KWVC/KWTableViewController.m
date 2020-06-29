//
//  KWTableViewController.m
//  MiniChat
//
//  Created by kwni on 2020/6/29.
//  Copyright © 2020 kwni. All rights reserved.
//

#import "KWTableViewController.h"
#import "KWMessageModel.h"
#import "KWMessageFrameModel.h"
#import "KWRightMessageFrameModel.h"
#import "KWTableViewCell.h"

@interface KWTableViewController ()

@end

@implementation KWTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //隐藏系统tableViewCell分割线
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    //隐藏垂直滚动条
    self.tableView.showsVerticalScrollIndicator = NO;

    //获取数据
    [self getInfo];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Incomplete implementation, return the number of sections
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of rows
    return self.KWInfoArray.count;
}

- (void)getInfo
{
    //实际开发数据是网络获取到的，这里模拟给出一个数据
    NSMutableArray *array = [[NSMutableArray alloc]initWithObjects:@{@"name" : @"你在干什么呀?", @"icon" : @"boy.png", @"text" : @""}, @{@"name" : @"刚吃完饭,你吃饭了吗?", @"icon" : @"girl.png", @"text" : @""},@{@"name" : @"还没有~", @"icon" : @"boy.png", @"text" : @""}, nil];
    
    //解析数据，转模型保存
    NSMutableArray *tempArray = [[NSMutableArray alloc] init];
    for (int i=0;i<array.count;i++) {
        NSDictionary *dict  = array[i];
        KWMessageModel *model = [KWMessageModel modelWithDict:dict];
        if(i%2 == 0){
            KWMessageFrameModel *frameModel = [[KWMessageFrameModel alloc] init];
            frameModel.model = model;
            [tempArray addObject:frameModel];
        }else{
            KWRightMessageFrameModel *frameModel = [[KWRightMessageFrameModel alloc] init];
            frameModel.model = model;
            [tempArray addObject:frameModel];
        }
        
    }
    self.KWInfoArray = [tempArray mutableCopy];
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    KWTableViewCell *cell = [KWTableViewCell cellWithTableView:tableView];
        
    cell.frameModel = self.KWInfoArray[indexPath.row];
        
    return cell;
}

//设置行高
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    KWMessageFrameModel *frameModel = self.KWInfoArray[indexPath.row];
    
    return frameModel.cellHeight;
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
