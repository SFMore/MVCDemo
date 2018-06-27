//
//  TWListAgentCompanyModel.h
//  MVCDemo
//
//  Created by zsf on 2018/6/26.
//  Copyright © 2018年 zsf. All rights reserved.
//

#import "TWBaseModel.h"
#import <MJExtension.h>
@interface TWAgentCompanyItemModel: TWBaseModel
@property (nonatomic,assign)BOOL checked;
@property (nonatomic,copy)  NSString *color;
@property (nonatomic,copy)  NSString *name;
@property (nonatomic,copy)  NSString *simpleName;
@property (nonatomic,assign)NSInteger id;
@end



@interface TWListAgentCompanyModel : TWBaseModel

@property (nonatomic,assign) NSInteger errorCode;
@property (nonatomic,copy) NSString *msg;
@property (nonatomic,assign) BOOL success;
@property (nonatomic,strong) NSArray *data;
@end
