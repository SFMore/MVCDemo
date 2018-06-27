//
//  TWApiManager.h
//  TWNetworking
//
//  Created by zsf on 2018/6/21.
//  Copyright © 2018年 zsf. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TWApiManager : NSObject

/// 默认POST请求
+ (NSNumber *)requestWithUrl:(NSString *)url parameters:(NSDictionary *)parameter success:(void(^)(id response))success failure:(void(^)(NSError *error))failure;
@end
