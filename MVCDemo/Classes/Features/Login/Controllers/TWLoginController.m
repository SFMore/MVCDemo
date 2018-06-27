//
//  TWLoginController.m
//  MVCDemo
//
//  Created by zsf on 2018/6/22.
//  Copyright © 2018年 zsf. All rights reserved.
//

#import "TWLoginController.h"
#import <objc/runtime.h>
#import "TWLoginControllerView.h"
#import "TWMacroDefinitions.h"
#import "TWLoginSerivce.h"
@interface TWLoginController ()<TWLoginControllerView>

@end

@implementation TWLoginController

kBINDVIEW(TWLoginControllerView, [UIScreen mainScreen].bounds)

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.closeButton addTarget:self action:@selector(close) forControlEvents:UIControlEventTouchUpInside];
    [self.loginButton addTarget:self action:@selector(login) forControlEvents:UIControlEventTouchUpInside];
}

- (void)close
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)login
{

    [TWLoginSerivce loginWithAccount:self.accountField.text password:self.pwdField.text callback:^(id respone, NSError *error) {
        if (error == nil) {
           
            if ([respone[@"errorCode"] integerValue] == 1) {
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [self dismissViewControllerAnimated:YES completion:nil];
                });
            }
           
        }else {
            
        }
        
    }];
}

@end
