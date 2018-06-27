//
//  QueryListAgentCompany.h
//  MVCDemo
//
//  Created by zsf on 2018/6/26.
//  Copyright © 2018年 zsf. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TWListAgentCompanyModel.h"
@interface TWListAgentCompanyService : NSObject
+ (void)requestListAgentCompanyWithDict:(NSDictionary *)dict callback:(void(^)(TWListAgentCompanyModel *model, NSError *error))callback;
@end
