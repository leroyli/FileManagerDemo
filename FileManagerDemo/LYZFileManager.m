//
//  LYZFileManager.m
//  FileManagerDemo
//
//  Created by artios on 2017/12/19.
//  Copyright © 2017年 artios. All rights reserved.
//

#import "LYZFileManager.h"

#define kDirectoryName @"Cache_File"

@implementation LYZFileManager


+ (BOOL)fileIsExistForPath:(NSString *)path {
    if (!path) {return NO;}
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL isExist = [fileManager fileExistsAtPath:path];
    return isExist;
}

+ (BOOL)removeFileWithPath:(NSString *)path {
    if (!path) {return NO;}
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL isExist = [fileManager fileExistsAtPath:path];
    
    if (!isExist) {
        NSLog(@">>>>>>>>>>file is dont exist");
        return NO;
    } else {
        BOOL isDelete = [fileManager removeItemAtPath:path error:nil];
        
        if (isDelete) {
            NSLog(@">>>>>>>>file delete success");
        } else {
            NSLog(@">>>>>>>>file delete failed");
        }
        return isDelete;
    }
}

/** 清除指定路径下的文件 */
+ (void)clearDirectoryCache:(NSString *)path {
    if (!path) {return;}
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    if ([fileManager fileExistsAtPath:path]) {
        
        NSArray *childerFiles = [fileManager subpathsAtPath:path];
        
        for (NSString *fileName in childerFiles) {
            
            /** 如有需要，加入条件，过滤掉不想删除的文件 */
            NSString *absolutePath = [path stringByAppendingPathComponent:fileName];
            [fileManager removeItemAtPath:absolutePath error:nil];
        }
        NSLog(@">>>>>>>>> clear success");
    }
}

+ (NSString *)filePathForfileName:(NSString *)fileName {
    if (!fileName) {return nil;}
    NSString *documentsDirectory = [self documentPath];
    NSString *dataPath           = [documentsDirectory stringByAppendingPathComponent:kDirectoryName];
    
    if (![[NSFileManager defaultManager] fileExistsAtPath:dataPath]) {
        [[NSFileManager defaultManager] createDirectoryAtPath:dataPath withIntermediateDirectories:NO attributes:nil error:nil];
    }
    
    NSString *filepath = [[NSString alloc] initWithString:[NSString stringWithFormat:@"%@/%@",dataPath,fileName]];
    
    return filepath;
}

+ (NSString *)fileDirectory {
    NSString *documentsDirectory = [self documentPath];
    NSString *dataPath           = [documentsDirectory stringByAppendingPathComponent:kDirectoryName];
    
    if (![[NSFileManager defaultManager] fileExistsAtPath:dataPath]) {
        [[NSFileManager defaultManager] createDirectoryAtPath:dataPath withIntermediateDirectories:NO attributes:nil error:nil];
    }
    
    return dataPath;
}

+ (BOOL)createDirectory:(NSString *)dirName {
    if (!dirName) {return NO;}
    NSString      *documentsPath = [self documentPath];
    NSFileManager *fileManager   = [NSFileManager defaultManager];
    NSString      *iOSDirectory  = [documentsPath stringByAppendingPathComponent:dirName];
    BOOL isSuccess = [fileManager createDirectoryAtPath:iOSDirectory withIntermediateDirectories:YES attributes:nil error:nil];
    if (isSuccess) {
        NSLog(@">>>>>>>>>>>>> creatDir success");
    } else {
        NSLog(@">>>>>>>>>>>>> creatDir fail");
    }
    return isSuccess;
}

+ (NSString *)saveFileWithName:(NSString *)name path:(NSString *)path {
    if (!path) {return nil;}
    NSURL *url = [NSURL fileURLWithPath:path];
    
    NSData *fileData = [NSData dataWithContentsOfURL:url];
    NSString *documentsDirectory = [self documentPath];
    
    NSString *filePath = [documentsDirectory stringByAppendingPathComponent:kDirectoryName];
    
    if (![[NSFileManager defaultManager] fileExistsAtPath:filePath]) {
        [[NSFileManager defaultManager] createDirectoryAtPath:filePath withIntermediateDirectories:NO attributes:nil error:nil];
    }
    
    NSString *saveFilePath = [[NSString alloc] initWithString:[NSString stringWithFormat:@"%@/%@",filePath,name]];
    BOOL success = [fileData writeToFile:saveFilePath atomically:NO];
    
    if (success) {
        NSLog(@">>>>>>>>>>save file success");
    } else {
        NSLog(@">>>>>>>>>>save file success");
    }
    
    return saveFilePath;
}

+ (CGFloat)fileSizeAtPath:(NSString *)filePath {
    if (!filePath) {return 0.0f;}
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL isExist = [fileManager fileExistsAtPath:filePath];
    if (isExist){
        unsigned long long fileSize = [[fileManager attributesOfItemAtPath:filePath error:nil] fileSize];
        return fileSize / (1024.0 * 1024.0);
    } else {
        NSLog(@">>>>>>>> file is not exist");
        return 0;
    }
}


+ (CGFloat)folderSizeAtPath:(NSString *)folderPath {
    if (!folderPath) {return 0.0f;}
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL isExist = [fileManager fileExistsAtPath:folderPath];
    
    if (isExist) {
        NSEnumerator *childFileEnumerator = [[fileManager subpathsAtPath:folderPath] objectEnumerator];
        unsigned long long folderSize = 0;
        NSString *fileName = @"";
        
        while ((fileName = [childFileEnumerator nextObject]) != nil) {
            NSString *fileAbsolutePath = [folderPath stringByAppendingPathComponent:fileName];
            folderSize += [self fileSizeAtPath:fileAbsolutePath];
        }
        return folderSize / (1024.0 * 1024.0);
    } else {
        NSLog(@">>>>>>>>> file is not exist");
        return 0;
    }
}

+ (BOOL)renameFileWitholdName:(NSString *)oldName newName:(NSString *)newName {
    NSString *cacheDir = [self fileDirectory];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString *filePath = [cacheDir stringByAppendingPathComponent:oldName];
    NSString *moveToPath = [cacheDir stringByAppendingPathComponent:newName];
    
    BOOL isSuccess = [fileManager moveItemAtPath:filePath toPath:moveToPath error:nil];
    if (isSuccess) {
        NSLog(@">>>>>>>>> rename success");
    } else {
        NSLog(@">>>>>>>>> rename fail");
    }
    return isSuccess;
}

+ (NSString *)writeToFileWithData:(NSData *)data fileName:(NSString *)fileName {
    if (!data) {return nil;}
    NSString *cacheDir = [self fileDirectory];
    NSString *filePath = [cacheDir stringByAppendingPathComponent:fileName];
    BOOL isSuccess = [data writeToFile:filePath atomically:YES];
    if (isSuccess) {
        return filePath;
    }
    return nil;
}

+ (NSArray *)getAllNameWithDirectoryPath:(NSString *)path {
    if (!path) {return nil;}
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSArray *fileNamesArray    = [fileManager subpathsAtPath:path];
    return fileNamesArray;
}

/*
 SDImage第三方清除缓存的方法
[[SDImageCache sharedImageCache] clearDisk];
[[SDImageCache sharedImageCache] clearMemory];
*/

+ (NSDictionary *)fileAttributeAtPath:(NSString *)path {
    if (!path) {return nil;}
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSError *error = nil;
    NSDictionary *fileAttributes = [fileManager attributesOfItemAtPath:path error:&error];
    /* 属性打印格式如下
     NSFileCreationDate = "2017-12-29 02:48:54 +0000";
     NSFileExtensionHidden = 0;
     NSFileGroupOwnerAccountID = 20;
     NSFileGroupOwnerAccountName = staff;
     NSFileModificationDate = "2017-12-29 02:48:54 +0000";
     NSFileOwnerAccountID = 501;
     NSFilePosixPermissions = 493;
     NSFileReferenceCount = 2;
     NSFileSize = 64;
     NSFileSystemFileNumber = 8595439046;
     NSFileSystemNumber = 16777220;
     NSFileType = NSFileTypeDirectory;
     */
    
    if (fileAttributes == nil) {
        NSLog(@">>>>>>>Path (%@) is invalid.", path);
    }
    return fileAttributes;
}

/** 沙盒->Cache目录 */
+ (NSString *)cachePath {
    NSArray  *cachesPath = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString *cachePath  = [cachesPath objectAtIndex:0];
    return cachePath;
}

/** 沙盒->Document目录 */
+ (NSString *)documentPath {
    NSArray  *paths              = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    return documentsDirectory;
}




@end
