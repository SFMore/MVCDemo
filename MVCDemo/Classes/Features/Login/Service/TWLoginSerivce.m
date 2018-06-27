//
//  TWLoginSerivce.m
//  MVCDemo
//
//  Created by zsf on 2018/6/26.
//  Copyright © 2018年 zsf. All rights reserved.
//

#import "TWLoginSerivce.h"
#import "TWApiManager.h"
@implementation TWLoginSerivce

+ (void)loginWithAccount:(NSString *)account password:(NSString *)pwd callback:(void(^)(id model,NSError *error))callback
{
    if (account.length == 0) {
        NSLog(@"用户名不能为空");
        return;
    }else if (pwd.length == 0){
        NSLog(@"密码不能为空");
        return;
    }
    
    
    NSDictionary *dict = @{@"username":account,@"password":pwd};
    [TWApiManager requestWithUrl:@"http://192.168.200.205:8408/login" parameters:dict success:^(id response) {
        callback(response,nil);
    } failure:^(NSError *error) {
        callback(nil,error);
    }];
}
@end
