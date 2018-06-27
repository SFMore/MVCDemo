//
//  TWDetailControllerView.m
//  MVCDemo
//
//  Created by zsf on 2018/6/26.
//  Copyright © 2018年 zsf. All rights reserved.
//

#import "TWDetailControllerView.h"
#import <Masonry.h>
@implementation TWDetailControllerView

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
    _button = [[UIButton alloc] initWithFrame:CGRectZero];
    _button.backgroundColor = [[UIColor redColor] colorWithAlphaComponent:0.8];
    [_button setTitle:@"完成" forState:UIControlStateNormal];
    [self addSubview:_button];
}


- (void)layoutSubviews
{
    [super layoutSubviews];
    
    [_button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(20);
        make.right.equalTo(self).offset(-20);
        make.bottom.equalTo(self).offset(-20);
        make.height.equalTo(@50);
    }];
}
@end
