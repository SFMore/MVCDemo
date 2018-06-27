//
//  TWListAgentCompanyModel.m
//  MVCDemo
//
//  Created by zsf on 2018/6/26.
//  Copyright © 2018年 zsf. All rights reserved.
//

#import "TWListAgentCompanyModel.h"
#import <MJExtension.h>
@implementation TWAgentCompanyItemModel

@end


@implementation TWListAgentCompanyModel

+ (NSDictionary *)mj_objectClassInArray
{
    return @{@"data":[TWAgentCompanyItemModel class]};
}

@end
