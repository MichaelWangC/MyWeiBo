//
//  AccessToken.h
//  MyWeiBo
//
//  Created by ZYmac on 14-9-10.
//  Copyright (c) 2014年 samples. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AccessToken : NSObject<NSCoding>

@property (nonatomic,copy) NSString *accessToken;
@property (nonatomic,copy) NSString *uid;

@end
