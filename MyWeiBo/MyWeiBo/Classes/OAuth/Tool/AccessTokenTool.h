//
//  AccessTokenTool.h
//  MyWeiBo
//
//  Created by ZYmac on 14-9-10.
//  Copyright (c) 2014年 samples. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AccessToken.h"

@interface AccessTokenTool : NSObject

+(AccessTokenTool *)shareAccessTokenTool;
//保存accessToken
-(void)saveAccessToken:(AccessToken *)account;
//删除accessToken
-(void)deleteAccessToken;

@property (nonatomic,strong) AccessToken *account;

@end
