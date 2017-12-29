//
//  LYZFileManager.h
//  FileManagerDemo
//
//  Created by artios on 2017/12/19.
//  Copyright © 2017年 artios. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface LYZFileManager : NSObject

/**
 判断文件是否存在

 @param path 路径
 @return 是否存在
 */
+ (BOOL)fileIsExistForPath:(NSString *)path;

/**
 移除本地缓存的文件
 
 @param path 路径
 */
+ (BOOL)removeFileWithPath:(NSString *)path;

/**
 删除一个文件夹里所有文件

 @param path 文件夹路径
 */
+ (void)clearDirectoryCache:(NSString *)path;

/**
 保存文件(文件名需加后缀)

 @param name 文件名
 @param path 文件路径
 @return 保存后的路径
 */
+ (NSString *)saveFileWithName:(NSString *)name path:(NSString *)path;

/**
 缓存文件的文件夹
 
 @return 文件夹名字
 */
+ (NSString *)fileDirectory;

/**
 创建文件夹

 @param dirName 名字
 @return 是否成功
 */
+ (BOOL)createDirectory:(NSString *)dirName;

/**
 根据文件名字获取文件路径(文件名需加后缀)
 
 @param fileName 文件名
 @return 文件路径
 */
+ (NSString *)filePathForfileName:(NSString *)fileName;

/**
 获取一个文件夹下所有文件名

 @param path 文件夹路径
 @return 文件名数组
 */
+ (NSArray *)getAllNameWithDirectoryPath:(NSString *)path;

/**
 计算文件大小

 @param filePath 文件路径
 @return 文件大小
 */
+ (CGFloat)fileSizeAtPath:(NSString *)filePath;

/**
 计算整个文件夹的大小

 @param folderPath 文件夹路径
 @return 大小
 */
+ (CGFloat)folderSizeAtPath:(NSString *)folderPath;

/**
 重命名文件(文件名需加后缀)

 @param oldName 老名字
 @param newName 新名字
 @return 是否成功
 */
+ (BOOL)renameFileWitholdName:(NSString *)oldName newName:(NSString *)newName;

/**
 写文件

 @param data 文件数据
 @param fileName 文件名
 @return 文件路径
 */
+ (NSString *)writeToFileWithData:(NSData *)data fileName:(NSString *)fileName;

/**
 获取文件属性

 @param path 文件路径
 @return 属性集合
 */
+ (NSDictionary *)fileAttributeAtPath:(NSString *)path;

/**
 沙盒Cache目录

 @return 路径
 */
+ (NSString *)cachePath;

/**
 沙盒Document目录

 @return 路径
 */
+ (NSString *)documentPath;


@end
