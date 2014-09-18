//
//  HttpTool.h
//  MyWeiBo
//
//  Created by ZYmac on 14-9-10.
//  Copyright (c) 2014年 samples. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^HttpSuccessBlock)(id responseObject);
typedef void (^HttpFailureBlock)(NSError *error);

@interface HttpTool : NSObject

+(void)getWithUrl:(NSString *)url parameters:(NSDictionary *)dict success:(HttpSuccessBlock)success failure:(HttpFailureBlock)failure;
+(void)postWithUrl:(NSString *)url parameters:(NSDictionary *)dict success:(HttpSuccessBlock)success failure:(HttpFailureBlock)failure;
+(void)loadImageWithUrl:(NSString *)imageUrl place:(UIImage *)place imageView:(UIImageView *)imageView;

@end
