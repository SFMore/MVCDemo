//
//  HomePageView.m
//  MVCDemo
//
//  Created by zsf on 2018/6/26.
//  Copyright © 2018年 zsf. All rights reserved.
//

#import "TWHomePageView.h"

@implementation TWHomePageView

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
    _tableView = [[UITableView alloc] initWithFrame:self.bounds style:UITableViewStylePlain];
    [self addSubview:_tableView];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    _tableView.frame = self.bounds;
}
@end
