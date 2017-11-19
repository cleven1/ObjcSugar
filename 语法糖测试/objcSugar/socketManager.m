//
//  socketManager.m
//  socketTest
//
//  Created by tusm on 2017/4/20.
//  Copyright © 2017年 cleven. All rights reserved.
//

#import "socketManager.h"
#import <sys/socket.h>
#import <netinet/in.h>
#import <arpa/inet.h>

#define TCPHOSTADDNUM   **ip地址**
@interface socketManager ()<NSStreamDelegate>
{
    NSInputStream *inputStream;
    NSOutputStream *outputStream;
}
@end

@implementation socketManager

+ (instancetype)shareTCPClient {
    static socketManager *sManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sManager = [[socketManager alloc] init];
    });
    return sManager;
}

- (BOOL)connection:(NSString *)hostText port:(int)port{
    
    /**
     socket   参数
     domain:  协议域，AF_INET（IPV4的网络开发）
     type:    Socket 类型，SOCK_STREAM(TCP)/SOCK_DGRAM(UDP，报文)
     protocol:IPPROTO_TCP，协议，如果输入0，可以根据第二个参数，自动选择协议
     return:  if > 0 就表示成功
     */
    self.clientSocket = - 1;
    self.clientSocket = socket(AF_INET, SOCK_STREAM, 0);
    
    if (self.clientSocket > 0) {
        NSLog(@"socket 连接成功： %d", self.clientSocket);
        
    } else {
        NSLog(@"socket 连接失败");
        return NO;
    }
    
    NSString *tcpIp = hostText;
    //Connect
    struct sockaddr_in serverAddress;
    serverAddress.sin_family = AF_INET;
    serverAddress.sin_addr.s_addr = inet_addr(tcpIp.UTF8String);
    serverAddress.sin_port = htons(port);
    self.result = connect(self.clientSocket, (const struct sockaddr *)&serverAddress, sizeof(serverAddress));
    
    if (self.clientSocket > 0 && self.result >= 0) {
        NSLog(@"connect 连接成功");
        return YES;
    }else {
        NSLog(@"connect 连接失败");
        
        [[socketManager shareTCPClient] disConnection];
        return NO;
    }
}

//2.3、发送 NSString 数据
//发送和接收字符串
- (void)sendStringToServerAndReceived:(NSString *)message {
    
    if (self.clientSocket > 0 && self.result >= 0) {
        
        //不加下面的代码，如果在发送数据的途中服务器断开连接，会闪退。
        sigset_t set;
        sigemptyset(&set);
        sigaddset(&set, SIGPIPE);
        sigprocmask(SIG_BLOCK, &set, NULL);
        ssize_t sendLen = send(self.clientSocket, message.UTF8String, strlen(message.UTF8String), 0);
        NSLog(@"发送的TCP数据长度 == %ld", sendLen);
        if (sendLen > 0) {
            [self performSelectorInBackground:@selector(readStream) withObject:nil];
        }
    }else {
        //发送的时候如果连接失败，重新连接。
    }
}
- (void)sendFileToServerAndReceived:(NSData *)fileData filePath:(NSString *)filePath
{
    if (self.clientSocket > 0 && self.result >= 0) {

        
        //不加下面的代码，如果在发送数据的途中服务器断开连接，会闪退。
        sigset_t set;
        sigemptyset(&set);
        sigaddset(&set, SIGPIPE);
        sigprocmask(SIG_BLOCK, &set, NULL);
        
        const char *resultCString = NULL;
        if ([filePath canBeConvertedToEncoding:NSUTF8StringEncoding]) {
            resultCString = [filePath cStringUsingEncoding:NSUTF8StringEncoding];
        }
        int fd = open(resultCString, O_RDONLY);

        char *voice_buf = (char *)calloc(1, fileData.length);
        int len = read(fd, (void *)voice_buf, (long)fileData.length);
        ssize_t sendLen = send(self.clientSocket, voice_buf, fileData.length, 0);
        NSLog(@"发送的TCP数据长度 == %ld", sendLen);
        if (sendLen > 0) {
            [self performSelectorInBackground:@selector(readStream) withObject:nil];
        }
    }
    
}

- (void)sendFileToServerAndReceived:(NSData *)fileData
{
    if (self.clientSocket > 0 && self.result >= 0) {

        //不加下面的代码，如果在发送数据的途中服务器断开连接，会闪退。
        sigset_t set;
        sigemptyset(&set);
        sigaddset(&set, SIGPIPE);
        sigprocmask(SIG_BLOCK, &set, NULL);
        
        char *tempBuf = calloc(1, fileData.length);
        [fileData getBytes:tempBuf length:fileData.length];

        ssize_t sendLen = send(self.clientSocket, tempBuf, fileData.length, 0);
        NSLog(@"发送的TCP数据长度 == %ld", sendLen);
        free(tempBuf);
    }
    
}

//2.4、接收数据
//接收数据
- (void)readStream {
    
    /**
     第一个int:创建的socket
     void *:  接收内容的地址
     size_t:  接收内容的长度
     第二个int:接收数据的标记 0，就是阻塞式，一直等待服务器的数据
     return:  接收到的数据长度
     */
    char readBuffer[1024] = {0};
    long OrgBr = 0;
    OrgBr = recv(self.clientSocket, readBuffer, sizeof(readBuffer), 0) < sizeof(readBuffer);
    NSLog(@"\nbr = %ld\nReceived Data：%s\n", OrgBr, readBuffer);
    memset(readBuffer, 0, sizeof(readBuffer));
    NSString * readString = [NSString stringWithUTF8String:readBuffer];
    if (readString && ![readString isKindOfClass:[NSNull class]] && readString.length > 0) {
        //接收到的数据 NSString 可以自己做相关的操作
    }else {
        //重新连接
    }
}
//2.5、 断开 Socket 连接
//断开连接
- (void)disConnection {
    
    if (self.clientSocket > 0) {
        close(self.clientSocket);
        self.clientSocket = -1;
    }
}

@end
