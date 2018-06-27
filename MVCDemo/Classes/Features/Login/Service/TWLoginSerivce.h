//
//  TWLoginSerivce.h
//  MVCDemo
//
//  Created by zsf on 2018/6/26.
//  Copyright © 2018年 zsf. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TWLoginSerivce : NSObject

+ (void)loginWithAccount:(NSString *)account password:(NSString *)pwd callback:(void(^)(id model,NSError *error))callback;
@end
