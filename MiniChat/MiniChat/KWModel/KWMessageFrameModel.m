//
//  KWMessageFrameModel.m
//  MiniChat
//
//  Created by kwni on 2020/6/29.
//  Copyright © 2020 kwni. All rights reserved.
//

#import "KWMessageFrameModel.h"

#define mainW [UIScreen mainScreen].bounds.size.width
#define HWTextFont [UIFont systemFontOfSize:15]


@implementation KWMessageFrameModel

- (void)setModel:(KWMessageModel *)model
{
    _model = model;
    //头像
    CGFloat padding = 10;
    CGFloat iconWH = 30;
    self.iconFrame = CGRectMake(padding, padding, iconWH, iconWH);
    
    //名字
    CGSize nameSize = [self sizeWithText:model.name font:HWTextFont maxSize:CGSizeMake(MAXFLOAT, MAXFLOAT)];
    CGFloat nameW = nameSize.width;
    CGFloat nameH = nameSize.height;
    CGFloat nameX = CGRectGetMaxX(self.iconFrame) + padding;
    CGFloat nameY = CGRectGetMinY(self.iconFrame) + padding/2;
    self.nameFrame = CGRectMake(nameX, nameY, nameW, nameH);
    
    //文字内容
    CGSize textSize = [self sizeWithText:model.text font:HWTextFont maxSize:CGSizeMake(mainW - padding * 2, MAXFLOAT)];
    self.textFrame = CGRectMake(padding, iconWH + padding * 2, textSize.width, textSize.height);
    
    //配图
    if (model.picture) {
        self.pictureFrame = CGRectMake(padding, CGRectGetMaxY(self.textFrame) + padding, 120, 120);
        _cellHeight = CGRectGetMaxY(self.pictureFrame) + padding;
    }
    else {
        _cellHeight = CGRectGetMaxY(self.textFrame) + padding;
    }
}
 
//根据字体大小、限定长度动态获取文字宽高尺寸
- (CGSize)sizeWithText:(NSString *)text font:(UIFont *)font maxSize:(CGSize)maxSize
{
    NSDictionary *dict = @{NSFontAttributeName : font};
    return [text boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:dict context:nil].size;
}

@end
