//
//  KWMessageFrameModel.h
//  MiniChat
//
//  Created by kwni on 2020/6/29.
//  Copyright © 2020 kwni. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "KWMessageModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface KWMessageFrameModel : NSObject


@property (nonatomic, assign) CGRect iconFrame;
@property (nonatomic, assign) CGRect nameFrame;
@property (nonatomic, assign) CGRect textFrame;
@property (nonatomic, assign) CGRect pictureFrame;
@property (nonatomic, assign) CGFloat cellHeight;
@property (nonatomic, strong) KWMessageModel *model;

@end

NS_ASSUME_NONNULL_END
