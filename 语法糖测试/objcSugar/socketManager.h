//
//  socketManager.h
//  socketTest
//
//  Created by tusm on 2017/4/20.
//  Copyright © 2017年 cleven. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface socketManager : NSObject

@property (nonatomic, assign) int clientSocket;
@property (nonatomic, assign) int result;

+ (instancetype)shareTCPClient;
//建立连接
- (BOOL)connection:(NSString *)hostText port:(int)port;
//发送字符串数据
- (void)sendStringToServerAndReceived:(NSString *)message;

//发送data类型数据,在沙盒中获取文件
- (void)sendFileToServerAndReceived:(NSData *)fileData filePath:(NSString *)filePath;

//直接发送data数据
- (void)sendFileToServerAndReceived:(NSData *)fileData;

//断开连接
- (void)disConnection;
@end
