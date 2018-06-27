//
//  TWDetailControllerView.h
//  MVCDemo
//
//  Created by zsf on 2018/6/26.
//  Copyright © 2018年 zsf. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol TWDetailControllerView

@optional
@property (nonatomic,strong)UIButton *button;

@end


@interface TWDetailControllerView : UIView

@property(nonatomic,strong)UIButton *button;


@end
