//
//  TWApiManager.m
//  TWNetworking
//
//  Created by zsf on 2018/6/21.
//  Copyright © 2018年 zsf. All rights reserved.
//

#import "TWApiManager.h"
#import "TWApiProxy.h"
@implementation TWApiManager



+ (NSNumber *)requestWithUrl:(NSString *)url parameters:(NSDictionary *)parameter success:(void(^)(id response))success failure:(void(^)(NSError *error))failure
{
     // 在请求之前你可以统一配置你请求的相关参数 ,设置请求头, 请求参数的格式, 返回数据的格式....这样你就不需要每次请求都要设置一遍相关参数
    
  
    NSString *urlStr = ([url hasPrefix:@"http://"] || [url hasPrefix:@"https://"]) ? url : [NSString stringWithFormat:@"%@/%@",@"http://www.taiwu.com",url];
    
    return [[TWApiProxy sharedInstance] sendRequestWithMethod:TWHttpRequestMethodPost url:urlStr parameters:parameter success:^(id responseObject) {
        
        success(responseObject);
        
    } failure:^(NSError *error) {
        
        failure(error);
        
    }];
}
                                                                                     
                                                                                     
                                                                                     
                                                                                     
@end
