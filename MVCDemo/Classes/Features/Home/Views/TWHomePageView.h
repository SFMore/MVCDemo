//
//  HomePageView.h
//  MVCDemo
//
//  Created by zsf on 2018/6/26.
//  Copyright © 2018年 zsf. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol TWHomePageView
@optional
@property (nonatomic,strong) UITableView *tableView;

@end

@interface TWHomePageView : UIView
@property (nonatomic,strong) UITableView *tableView;
@end
