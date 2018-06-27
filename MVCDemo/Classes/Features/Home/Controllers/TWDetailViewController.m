//
//  TWDetailViewController.m
//  MVCDemo
//
//  Created by zsf on 2018/6/26.
//  Copyright © 2018年 zsf. All rights reserved.
//

#import "TWDetailViewController.h"
#import "TWDetailControllerView.h"
#import "TWMacroDefinitions.h"
#import "TWListAgentCompanyService.h"
#import <objc/runtime.h>


@interface TWDetailViewController ()<TWDetailControllerView>

@end

@implementation TWDetailViewController

kBINDVIEW(TWDetailControllerView, [UIScreen mainScreen].bounds)

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.button addTarget:self action:@selector(click) forControlEvents:UIControlEventTouchUpInside];
    
}


- (void)click
{
    //弹出loading... 等待框 ，并请求服务
    
    [TWListAgentCompanyService requestListAgentCompanyWithDict:nil callback:^(TWListAgentCompanyModel *model, NSError *error) {
            //销毁loading... 框
        
        if (error == nil) {
            
            if (model.errorCode == TWHttpResponseCodeSuccess) {
                
            }
            // 将model的数据更新到某个视图中去。
            
        }else {
           //网络请求失败处理
        }
    }];
    
    
}

@end
