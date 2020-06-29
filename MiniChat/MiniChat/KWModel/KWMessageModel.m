//
//  KWMessageModel.m
//  MiniChat
//
//  Created by kwni on 2020/6/29.
//  Copyright © 2020 kwni. All rights reserved.
//

#import "KWMessageModel.h"

@implementation KWMessageModel

- (id)initWithDict:(NSDictionary *)dict
{
    self = [super init];
    if (self) {
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}
 
+ (id)modelWithDict:(NSDictionary *)dict
{
    return [[self alloc] initWithDict:dict];
}


@end
