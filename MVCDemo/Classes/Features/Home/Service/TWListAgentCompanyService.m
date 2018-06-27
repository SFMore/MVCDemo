//
//  QueryListAgentCompany.m
//  MVCDemo
//
//  Created by zsf on 2018/6/26.
//  Copyright © 2018年 zsf. All rights reserved.
//

#import "TWListAgentCompanyService.h"
#import "TWApiManager.h"
@implementation TWListAgentCompanyService

+(void)requestListAgentCompanyWithDict:(NSDictionary *)dict callback:(void(^)(TWListAgentCompanyModel *model, NSError *error))callback
{
    [TWApiManager requestWithUrl:@"http://192.168.200.205:8408/store/listAgentCompany" parameters:dict success:^(id response) {
        
        TWListAgentCompanyModel *model = [TWListAgentCompanyModel mj_objectWithKeyValues:response];
        
        callback(model,nil);
        
    } failure:^(NSError *error) {
        callback(nil,error);
    }];
}

@end
