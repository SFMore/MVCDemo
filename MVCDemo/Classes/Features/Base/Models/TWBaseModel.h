//
//  TWBaseModel.h
//  MVCDemo
//
//  Created by zsf on 2018/6/26.
//  Copyright © 2018年 zsf. All rights reserved.
//

#import <Foundation/Foundation.h>

//网络请求返回状态码
typedef NS_ENUM(NSInteger, TWHttpResponseCode) {
    /// 成功
    TWHttpResponseCodeSuccess = 1,
    /// 无数据
    TWHttpResponseCodeNOData
};


@interface TWBaseModel : NSObject

@end
