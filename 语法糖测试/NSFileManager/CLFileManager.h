//
//  CLFileManager.h
//  SocketTestDemo
//
//  Created by 赵永强 on 2017/11/9.
//  Copyright © 2017年 cleven. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CLFileManager : NSObject

//创建文件夹Douctment下/目录
+ (BOOL)createDir:(NSString *)fileName;

//创建文件 默认在document目录下
+ (BOOL)createFileName:(NSString *)fileName withFileData:(NSData *)fileData;

//保存文件
+ (BOOL)saveToDirectory:(NSString *)path data:(NSData *)data name:(NSString *)newName;

//读文件数据
+ (NSData *)readFilePath:(NSString *)filePath;

//根据路径删除文件
+ (BOOL)deleteFileByFileType:(NSString *)fileType;

//根据文件名删除文件
+ (BOOL)deleteFileType:(NSString *)fileType fileByPath:(NSString *)filePath;

//根据路径复制文件
+ (BOOL)copyFileType:(NSString *)fileType topath:(NSString *)topath;

//根据路径剪切文件
+ (BOOL)cutFileType:(NSString *)fileType topath:(NSString *)topath;

//根据文件名获取资源文件路径
+ (NSString *)getResourcesFile:(NSString *)fileName;

//根据文件名获取文件路径
+ (NSString *)getLocalFilePath:(NSString *) fileName;

//根据文件路径获取文件名称
+ (NSString *)getFileNameByFileType:(NSString *)fileType;

//根据路径获取该路径下所有目录
+ (NSArray *)getAllFileByName:(NSString *)path;

//根据路径获取文件目录下所有文件
+ (NSArray *)getAllFloderByName:(NSString *)path;

//重命名文件或目录
+ (BOOL)renameFileName:(NSString *)oldName toNewName:(NSString *)newName;

//获取文件及目录的大小
+ (float)sizeOfDirectory:(NSString *)dir;

@end
