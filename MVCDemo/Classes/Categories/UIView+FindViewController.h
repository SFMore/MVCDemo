//
//  UIView+FindViewController.h
//  MVCDemo
//
//  Created by zsf on 2018/6/22.
//  Copyright © 2018年 zsf. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (FindViewController)
/**
 *  @brief  找到当前view所在的viewcontroler
 */
@property (readonly) UIViewController *viewController;
@end
