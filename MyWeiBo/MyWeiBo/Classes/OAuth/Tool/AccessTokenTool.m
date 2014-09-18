//
//  AccessTokenTool.m
//  MyWeiBo
//
//  Created by ZYmac on 14-9-10.
//  Copyright (c) 2014年 samples. All rights reserved.
//

#import "AccessTokenTool.h"

// 文件路径
#define kFile [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0] stringByAppendingPathComponent:@"account.data"]

@implementation AccessTokenTool

-(id)init{
    if (self = [super init]) {
        _account = [NSKeyedUnarchiver unarchiveObjectWithFile:kFile];
    }
    return self;
}

-(void)saveAccessToken:(AccessToken *)accessToken{
    _account = accessToken;
    [NSKeyedArchiver archiveRootObject:accessToken toFile:kFile];
}

-(void)deleteAccessToken{
    NSFileManager *fileM = [NSFileManager defaultManager];
    if ([fileM isDeletableFileAtPath:kFile]) {
        [fileM removeItemAtPath:kFile error:nil];
    }
}

//单例
static AccessTokenTool *Instance;
+(AccessTokenTool *)shareAccessTokenTool{
    if (nil == Instance) {
        Instance = [[self alloc]init];
    }
    return Instance;
}
+(id)allocWithZone:(struct _NSZone *)zone{
    if (nil == Instance) {
        Instance = [super allocWithZone:zone];
    }
    return Instance;
}

@end
