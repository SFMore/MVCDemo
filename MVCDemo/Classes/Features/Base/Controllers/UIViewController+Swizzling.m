//
//  UIViewController+Swizzling.m
//  MVCDemo
//
//  Created by zsf on 2018/6/22.
//  Copyright © 2018年 zsf. All rights reserved.
//

#import "UIViewController+Swizzling.h"
#import "SwizzlingDefine.h"
@implementation UIViewController (Swizzling)

+ (void)load
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        swizzling_exchangeMethod([UIViewController class] ,@selector(viewWillAppear:), @selector(swizzling_viewWillAppear:));
        swizzling_exchangeMethod([UIViewController class] ,@selector(viewDidAppear:), @selector(swizzling_viewDidAppear:));
        swizzling_exchangeMethod([UIViewController class] ,@selector(viewWillDisappear:), @selector(swizzling_viewWillDisappear:));
        swizzling_exchangeMethod([UIViewController class] ,@selector(viewDidLoad),    @selector(swizzling_viewDidLoad));
    });
}

#pragma mark - ViewDidLoad
- (void)swizzling_viewDidLoad
{
    if (self.navigationController) {
        UIImage *buttonNormal = [[UIImage imageNamed:@"icon_back_normal.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        [self.navigationController.navigationBar setBackIndicatorImage:buttonNormal];
        [self.navigationController.navigationBar setBackIndicatorTransitionMaskImage:buttonNormal];
        UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
        self.navigationItem.backBarButtonItem = backItem;
    }
    [self swizzling_viewDidLoad];
}

#pragma mark - ViewWillAppear
- (void)swizzling_viewWillAppear:(BOOL)animated
{
    [self swizzling_viewWillAppear:animated];
    
    if (self.parentViewController == self.navigationController)
    {
        if ([self swizzling_isUseClearBar] && self.navigationController)
        {
            [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
            [self.navigationController.navigationBar setShadowImage:[UIImage new]];
        }
        else
        {
            [self.navigationController.navigationBar setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
            [self.navigationController.navigationBar setShadowImage:nil];
        }
    }
}

#pragma mark - ViewDidAppear
- (void)swizzling_viewDidAppear:(BOOL)animated{
    [self swizzling_viewDidAppear:animated];
}

#pragma mark - ViewWillDisappear
- (void)swizzling_viewWillDisappear:(BOOL)animated{
    [self swizzling_viewWillDisappear:animated];
}


#pragma mark - Private
- (BOOL)swizzling_isUseClearBar
{
    SEL  sel = NSSelectorFromString(@"useClearBar");
    BOOL use = NO;
    if ([self respondsToSelector:sel]) {
        
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
    use = (BOOL)[self performSelector:sel];
#pragma clang diagnostic pop
    
    }
    return use;
}

@end
