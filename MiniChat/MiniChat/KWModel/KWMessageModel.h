//
//  KWMessageModel.h
//  MiniChat
//
//  Created by kwni on 2020/6/29.
//  Copyright © 2020 kwni. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface KWMessageModel : NSObject

@property (nonatomic, copy) NSString *icon;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *text;
@property (nonatomic, copy) NSString *picture;
 
- (id)initWithDict:(NSDictionary *)dict;
+ (id)modelWithDict:(NSDictionary *)dict;

@end

NS_ASSUME_NONNULL_END
