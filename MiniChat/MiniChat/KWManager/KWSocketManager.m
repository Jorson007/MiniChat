//
//  KWSocketManager.m
//  MiniChat
//
//  Created by kwni on 2020/6/28.
//  Copyright © 2020 kwni. All rights reserved.
//

#import "KWSocketManager.h"
#import <GCDAsyncSocket.h>

@interface KWSocketManager()<GCDAsyncSocketDelegate>
{
    GCDAsyncSocket *gcdSocket;
}

@end
@implementation KWSocketManager

+ (instancetype)share{
    static dispatch_once_t onceToken;
    static KWSocketManager *instance = nil;
    dispatch_once(&onceToken, ^{
        instance = [[KWSocketManager alloc]init];
        [instance initSocket];
    });
    return instance;
}

-(void) initSocket{
    gcdSocket = [[GCDAsyncSocket alloc] initWithDelegate:self delegateQueue:dispatch_get_main_queue()];
}
- (BOOL)connect{
    return  [gcdSocket connectToHost:@"127.0.0.1" onPort:6969 error:nil];
}
- (void)disConnect{
    [gcdSocket disconnect];
}
- (void)sendMsg:(NSString *)msg{
    NSData *data  = [msg dataUsingEncoding:NSUTF8StringEncoding];
    //第二个参数，请求超时时间
    [gcdSocket writeData:data withTimeout:-1 tag:110];
}

//监听最新的消息
- (void)pullTheMsg
{
    //貌似是分段读数据的方法
//    [gcdSocket readDataToData:[GCDAsyncSocket CRLFData] withTimeout:10 maxLength:50000 tag:110];
   
    //监听读数据的代理，只能监听10秒，10秒过后调用代理方法  -1永远监听，不超时，但是只收一次消息，
    //所以每次接受到消息还得调用一次
    [gcdSocket readDataWithTimeout:-1 tag:110];

}

//用Pingpong机制来看是否有反馈
- (void)checkPingPong
{
    //pingpong设置为3秒，如果3秒内没得到反馈就会自动断开连接
    [gcdSocket readDataWithTimeout:3 tag:110];

}


//连接成功调用
- (void)socket:(GCDAsyncSocket *)sock didConnectToHost:(NSString *)host port:(uint16_t)port
{
    NSLog(@"连接成功,host:%@,port:%d",host,port);
    
    [self checkPingPong];

    //心跳写在这...
}

//断开连接的时候调用
- (void)socketDidDisconnect:(GCDAsyncSocket *)sock withError:(nullable NSError *)err
{
    NSLog(@"断开连接,host:%@,port:%d",sock.localHost,sock.localPort);
    
    //断线重连写在这...

}

//写的回调
- (void)socket:(GCDAsyncSocket*)sock didWriteDataWithTag:(long)tag
{
    NSLog(@"写的回调,tag:%ld",tag);
    //判断是否成功发送，如果没收到响应，则说明连接断了，则想办法重连
    [self checkPingPong];
}


- (void)socket:(GCDAsyncSocket *)sock didReadData:(NSData *)data withTag:(long)tag
{

    NSString *msg = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    NSLog(@"收到消息：%@",msg);
    
    [self pullTheMsg];
}


@end
