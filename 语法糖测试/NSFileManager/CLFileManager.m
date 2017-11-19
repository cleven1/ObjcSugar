//
//  CLFileManager.m
//  SocketTestDemo
//
//  Created by 赵永强 on 2017/11/9.
//  Copyright © 2017年 cleven. All rights reserved.
//

#import "CLFileManager.h"

@interface CLFileManager()

@end

@implementation CLFileManager

//获取Documents目录路径
+ (NSString *)getDocumentsDirectory
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];

    return  documentsDirectory;
}

//获取Library目录路径
+ (NSString *)getLibraryDirectory
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES);
    NSString *libraryDirectory = [paths objectAtIndex:0];
    
    return libraryDirectory;
}

//获取Library/Caches目录路径
+ (NSString *)getCachesDirectory
{
    NSArray *cacPath = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString *cachePath = [cacPath objectAtIndex:0];
    
    return cachePath;
}

//获取Tmp目录路径
+ (NSString *)getTmpDirectory
{
    NSString *tmpDirectory = NSTemporaryDirectory();
    
    return tmpDirectory;
}

//创建文件夹Douctment下/目录
+ (BOOL)createDir:(NSString *)fileName
{

    NSString * path = [NSString stringWithFormat:@"%@/%@",[self getDocumentsDirectory],fileName];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL isDir;
    if  (![fileManager fileExistsAtPath:path isDirectory:&isDir]) {//先判断目录是否存在，不存在才创建
        BOOL res=[fileManager createDirectoryAtPath:path withIntermediateDirectories:YES attributes:nil error:nil];
        return res;
    } else return NO;
}

//创建文件 默认在document目录下
+ (BOOL)createFileName:(NSString *)fileName withFileData:(NSData *)fileData
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString *filePath = [[self getDocumentsDirectory] stringByAppendingPathComponent:fileName];//在传入的路径下创建fileName文件
    BOOL res=[fileManager createFileAtPath:filePath contents:nil attributes:nil];
    //通过data创建数据
    [fileManager createFileAtPath:filePath contents:fileData attributes:nil];
    return res;
}

//保存文件
+ (BOOL)saveToDirectory:(NSString *)path data:(NSData *)data name:(NSString *)newName
{
    NSString * resultPath = [path stringByAppendingPathComponent:[NSString stringWithFormat:@"/%@",newName]];
    return [[NSFileManager defaultManager] createFileAtPath:resultPath contents:data attributes:nil];
}

//读文件数据
+ (NSData *)readFilePath:(NSString *)filePath
{
    
    return [[NSFileManager defaultManager] contentsAtPath:filePath];
}

//根据路径删除文件
+ (BOOL)deleteFileByFileType:(NSString *)fileType
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    BOOL res = [fileManager removeItemAtPath:[self getDocumentsDirectory] error:nil];
    
    return res;
//    NSLog(@"文件是否存在: %@",[fileManager isExecutableFileAtPath:path]?@"YES":@"NO");
}

//根据文件名删除文件
+ (BOOL)deleteFileType:(NSString *)fileType fileByPath:(NSString *)filePath
{
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    BOOL res = [fileManager removeItemAtPath:[[self getDocumentsDirectory]stringByAppendingPathComponent:filePath] error:nil];
    
    return res;
//    NSLog(@"文件是否存在: %@",[fileManager isExecutableFileAtPath:path]?@"YES":@"NO");
}

//根据路径复制文件
+ (BOOL)copyFileType:(NSString *)fileType topath:(NSString *)topath
{
    BOOL result = NO;
    NSError * error = nil;
    
    result = [[NSFileManager defaultManager]copyItemAtPath:fileType toPath:topath error:&error ];
    
    if (error){
        NSLog(@"copy失败：%@",[error localizedDescription]);
    }
    return result;
}

//根据路径剪切文件
+ (BOOL)cutFileType:(NSString *)fileType topath:(NSString *)topath
{
    BOOL result = NO;
    NSError * error = nil;
    result = [[NSFileManager defaultManager]moveItemAtPath:fileType toPath:topath error:&error ];
    if (error){
        NSLog(@"cut失败：%@",[error localizedDescription]);
    }
    return result;
    
}

//根据文件名获取资源文件路径
+ (NSString *)getResourcesFile:(NSString *)fileName
{
    return [[NSBundle mainBundle] pathForResource:fileName ofType:nil];
}

//根据文件名获取文件路径
+ (NSString *)getLocalFilePath:(NSString *) fileName
{
    return [NSString stringWithFormat:@"%@/%@",[self getDocumentsDirectory],fileName];
}

//根据文件路径获取文件名称
+ (NSString *)getFileNameByFileType:(NSString *)fileType
{
    NSArray *array = [[self getDocumentsDirectory] componentsSeparatedByString:@"/"];
    if (array.count==0) return fileType;
    return [array objectAtIndex:array.count-1];
}

//根据路径获取该路径下所有目录
+ (NSArray *)getAllFileByName:(NSString *)path
{
    NSFileManager *defaultManager = [NSFileManager defaultManager];
    NSArray *array = [defaultManager contentsOfDirectoryAtPath:path error:nil];
    return array;
}

//根据路径获取文件目录下所有文件
+ (NSArray *)getAllFloderByName:(NSString *)path
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    NSArray * fileAndFloderArr = [self getAllFileByName:path];
    
    NSMutableArray *dirArray = [[NSMutableArray alloc] init];
    BOOL isDir = NO;
    //在上面那段程序中获得的fileList中列出文件夹名
    for (NSString * file in fileAndFloderArr){
        
        NSString *paths = [path stringByAppendingPathComponent:file];
        [fileManager fileExistsAtPath:paths isDirectory:(&isDir)];
        if (isDir) {
            [dirArray addObject:file];
        }
        isDir = NO;
    }
    return dirArray;
}

//重命名文件或目录
+ (BOOL)renameFileName:(NSString *)oldName toNewName:(NSString *)newName
{
    BOOL result = NO;
    NSError * error = nil;
    result = [[NSFileManager defaultManager] moveItemAtPath:[[self getDocumentsDirectory] stringByAppendingPathComponent:oldName] toPath:[[self getDocumentsDirectory] stringByAppendingPathComponent:newName] error:&error];
    
    if (error){
        NSLog(@"重命名失败：%@",[error localizedDescription]);
    }
    
    return result;
}

//获取文件及目录的大小
+ (float)sizeOfDirectory:(NSString *)dir
{
    NSDirectoryEnumerator *direnum = [[NSFileManager defaultManager] enumeratorAtPath:dir];
    NSString *pname;
    int64_t s=0;
    while (pname = [direnum nextObject]){
        //NSLog(@"pname   %@",pname);
        NSDictionary *currentdict=[direnum fileAttributes];
        NSString *filesize=[NSString stringWithFormat:@"%@",[currentdict objectForKey:NSFileSize]];
        NSString *filetype=[currentdict objectForKey:NSFileType];
        
        if([filetype isEqualToString:NSFileTypeDirectory]) continue;
        s=s+[filesize longLongValue];
    }
    return s*1.0;
}


@end
