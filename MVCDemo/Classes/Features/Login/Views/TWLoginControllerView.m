//
//  TWLoginControllerView.m
//  MVCDemo
//
//  Created by zsf on 2018/6/26.
//  Copyright © 2018年 zsf. All rights reserved.
//

#import "TWLoginControllerView.h"
#import <Masonry.h>
@implementation TWLoginControllerView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initUI];
    }
    return self;
}

- (void)initUI
{
    _closeButton = [[UIButton alloc] init];
    [_closeButton setTitle:@"关闭" forState:UIControlStateNormal];
    [_closeButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self addSubview:_closeButton];
    
    _accountField = [[UITextField alloc] init];
    _accountField.borderStyle = UITextBorderStyleLine;
    _accountField.placeholder = @"请输入账号";
    _accountField.font = [UIFont systemFontOfSize:16];
    _accountField.clearButtonMode = UITextFieldViewModeUnlessEditing;
    [self addSubview:_accountField];
    
    _pwdField = [[UITextField alloc] init];
    _pwdField.borderStyle = UITextBorderStyleLine;
    _pwdField.placeholder = @"请输入密码";
    _pwdField.font = [UIFont systemFontOfSize:16];
    _accountField.clearButtonMode = UITextFieldViewModeUnlessEditing;
    [self addSubview:_pwdField];
    
    _loginButton = [[UIButton alloc] init];
    [_loginButton setTitle:@"登录" forState:UIControlStateNormal];
    [_loginButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    _loginButton.backgroundColor = [[UIColor redColor] colorWithAlphaComponent:0.7];
    [self addSubview:_loginButton];
}


- (void)layoutSubviews
{
    [super layoutSubviews];
    
    [_closeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(30);
        make.left.equalTo(self).offset(25);
    }];
    
    [_accountField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(200);
        make.left.equalTo(self).offset(30);
        make.right.equalTo(self).offset(-30);
        make.height.equalTo(@50);
    }];
    
    [_pwdField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_accountField.mas_bottom).offset(20);
        make.left.right.height.equalTo(_accountField);
    }];
    
    [_loginButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_pwdField.mas_bottom).offset(40);
        make.left.right.height.equalTo(_pwdField);
    }];
}
@end
