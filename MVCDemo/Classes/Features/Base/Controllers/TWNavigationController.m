//
//  TWNavigationController.m
//  MVCDemo
//
//  Created by zsf on 2018/6/22.
//  Copyright © 2018年 zsf. All rights reserved.
//

#import "TWNavigationController.h"

@interface TWNavigationController ()

@end

@implementation TWNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    viewController.hidesBottomBarWhenPushed = self.viewControllers.count > 0;
    
    [super pushViewController:viewController animated:animated];
}
@end
