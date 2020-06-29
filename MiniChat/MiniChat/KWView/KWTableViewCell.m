//
//  KWTableViewCell.m
//  MiniChat
//
//  Created by kwni on 2020/6/29.
//  Copyright © 2020 kwni. All rights reserved.
//

#import "KWTableViewCell.h"
#import "KWMessageFrameModel.h"
#import "KWMessageModel.h"


#define HWTextFont [UIFont systemFontOfSize:15]

@interface KWTableViewCell()

@property (nonatomic, weak) UIImageView *icon;
@property (nonatomic, weak) UILabel *name;
@property (nonatomic, weak) UILabel *text;
@property (nonatomic, assign) UIImageView *picture;


@end

@implementation KWTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    //cell复用，唯一标识
    static NSString *identifier = @"HWCell";
    //先在缓存池中取
    KWTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    //缓存池中没有再创建，并添加标识，cell移出屏幕时放入缓存池以复用
    if (cell == nil) {
        cell = [[KWTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    
    return cell;
}
 
//重写init方法构建cell内容
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        //取消点击高亮状态
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        //头像
        UIImageView *icon = [[UIImageView alloc] init];
        [self.contentView addSubview:icon];
        self.icon = icon;
        
        //名字
        UILabel *name = [[UILabel alloc] init];
        name.font = HWTextFont;
        [self.contentView addSubview:name];
        self.name = name;
        
        //内容
        UILabel *text = [[UILabel alloc] init];
        text.numberOfLines = 0;
        text.font = HWTextFont;
        [self.contentView addSubview:text];
        self.text = text;
        
        //配图
        UIImageView *picture = [[UIImageView alloc] init];
        [self.contentView addSubview:picture];
        self.picture = picture;
    }
    
    return self;
}
 
//重写set方法，模型传递
- (void)setFrameModel:(KWMessageFrameModel *)frameModel
{
    _frameModel = frameModel;
    
    KWMessageModel *model = frameModel.model;
    
    self.icon.image = [UIImage imageNamed:model.icon];
    self.icon.frame = frameModel.iconFrame;
    
    self.name.text = model.name;
    self.name.frame = frameModel.nameFrame;
    
    self.text.text = model.text;
    self.text.frame = frameModel.textFrame;
    
    self.picture.image = [UIImage imageNamed:model.picture];
    self.picture.frame = frameModel.pictureFrame;
}

@end
