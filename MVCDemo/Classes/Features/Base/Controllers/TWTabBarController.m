//
//  TWTabBarController.m
//  MVCDemo
//
//  Created by zsf on 2018/6/22.
//  Copyright © 2018年 zsf. All rights reserved.
//

#import "TWTabBarController.h"
#import "TWNavigationController.h"
#import "TWMineViewController.h"
#import "TWHomePageController.h"


@interface TWTabBarController ()

@end

@implementation TWTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    TWHomePageController *homePageVC = [[TWHomePageController alloc] init];
    [self addChildVC:homePageVC title:@"首页" normalImageName:@"" selectedImageName:@""];
    
    TWMineViewController *mineVC = [[TWMineViewController alloc] init];
    [self addChildVC:mineVC title:@"我的" normalImageName:@"" selectedImageName:@""];
    
}

- (void)addChildVC:(UIViewController *)childVC title:(NSString *)title normalImageName:(NSString *)norImageName selectedImageName:(NSString *)selImageName
{
    TWNavigationController *nav = [[TWNavigationController alloc] initWithRootViewController:childVC];
    nav.tabBarItem.title = title;
    nav.tabBarItem.image = [UIImage imageNamed:norImageName];
    nav.tabBarItem.selectedImage = [UIImage imageNamed:selImageName];
    [self addChildViewController:nav];
    
}


@end
