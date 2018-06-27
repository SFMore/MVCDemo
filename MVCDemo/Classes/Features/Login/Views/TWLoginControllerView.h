//
//  TWLoginControllerView.h
//  MVCDemo
//
//  Created by zsf on 2018/6/26.
//  Copyright © 2018年 zsf. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol TWLoginControllerView

@optional
@property (nonatomic,strong)UITextField *accountField;
@property (nonatomic,strong)UITextField *pwdField;
@property (nonatomic,strong)UIButton *loginButton;
@property (nonatomic,strong)UIButton *closeButton;

@end

@interface TWLoginControllerView : UIView

@property (nonatomic,strong)UITextField *accountField;
@property (nonatomic,strong)UITextField *pwdField;
@property (nonatomic,strong)UIButton *loginButton;
@property (nonatomic,strong)UIButton *closeButton;

@end
