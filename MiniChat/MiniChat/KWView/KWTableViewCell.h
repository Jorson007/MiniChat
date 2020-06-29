//
//  KWTableViewCell.h
//  MiniChat
//
//  Created by kwni on 2020/6/29.
//  Copyright © 2020 kwni. All rights reserved.
//

#import <UIKit/UIKit.h>
@class KWMessageFrameModel;

NS_ASSUME_NONNULL_BEGIN

@interface KWTableViewCell : UITableViewCell

@property (nonatomic, strong) KWMessageFrameModel *frameModel;
 
+ (instancetype)cellWithTableView:(UITableView *)tableView;

@end

NS_ASSUME_NONNULL_END
