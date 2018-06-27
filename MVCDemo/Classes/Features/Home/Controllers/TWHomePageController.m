//
//  TWHomePageController.m
//  MVCDemo
//
//  Created by zsf on 2018/6/22.
//  Copyright © 2018年 zsf. All rights reserved.
//

#import "TWHomePageController.h"
#import "UIView+Present.h"
#import "TWHomePageView.h"
#import <objc/runtime.h>
#import "TWMacroDefinitions.h"
#import "TWDetailViewController.h"


@interface TWHomePageController ()<TWHomePageView,UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) UIView *redView;
@end

@implementation TWHomePageController

kBINDVIEW(TWHomePageView, [UIScreen mainScreen].bounds)

//-(void)loadView
//{
//    self.view = [[TWHomePageView alloc] initWithFrame:[UIScreen mainScreen].bounds];
//}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"首页";
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"展示" style:UIBarButtonItemStylePlain target:self action:@selector(show)];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"关闭" style:UIBarButtonItemStylePlain target:self action:@selector(dismiss)];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
}

//- (id)forwardingTargetForSelector:(SEL)aSelector
//{
//    struct objc_method_description omd = protocol_getMethodDescription(@protocol(TWHomePageView), aSelector, NO, YES);
//    if (omd.name != NULL) {
//        return self.view;
//    }
//
//    return [super forwardingTargetForSelector:aSelector];
//}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.textLabel.text = [NSString stringWithFormat:@"row==>a%ld",indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    TWDetailViewController *detailVC = [[TWDetailViewController alloc] init];
    [self.navigationController pushViewController:detailVC animated:YES];
}

- (void)show
{
    
    if (!_redView) {
        _redView  = [[UIView alloc] init];
        _redView.frame = CGRectMake(80, 80, 100, 100);
        _redView.backgroundColor = [UIColor redColor];
        
        [self.view presentView:_redView animated:YES complete:^{
        }];
    }
  
}

- (void)dismiss
{
    [self.view dismissPresentedView:YES complete:^{
        _redView = nil;
    }];
}

@end
