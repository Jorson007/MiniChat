//
//  KWSocketManager.h
//  MiniChat
//
//  Created by kwni on 2020/6/28.
//  Copyright © 2020 kwni. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface KWSocketManager : NSObject

+ (instancetype)share;
- (BOOL)connect;
- (void)disConnect;
- (void)sendMsg:(NSString *)msg;

@end

NS_ASSUME_NONNULL_END
