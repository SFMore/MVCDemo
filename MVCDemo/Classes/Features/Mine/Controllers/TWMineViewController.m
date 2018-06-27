//
//  TWMineViewController.m
//  MVCDemo
//
//  Created by zsf on 2018/6/25.
//  Copyright © 2018年 zsf. All rights reserved.
//

#import "TWMineViewController.h"
#import "TWLoginController.h"

@interface TWMineViewController ()

@end

@implementation TWMineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"登录" style:UIBarButtonItemStylePlain target:self action:@selector(login)];
}

- (void)login
{
    [self presentViewController:[TWLoginController alloc] animated:YES completion:nil];
}


@end
