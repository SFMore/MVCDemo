//
//  UIView+Present.m
//  MVCDemo
//
//  Created by zsf on 2018/6/22.
//  Copyright © 2018年 zsf. All rights reserved.
//

#import "UIView+Present.h"
#import <objc/runtime.h>
@implementation UIView (Present)


static char PresentedViewAddress;   //被Present的View
static char PresentingViewAddress;  //正在Present其他视图的view

#define AnimateDuartion .25f
- (void)presentView:(UIView*)view animated:(BOOL)animated complete:(void(^)()) complete{
    if (!self.window) {
        return;
    }
    [self.window addSubview:view];
    objc_setAssociatedObject(self, &PresentedViewAddress, view, OBJC_ASSOCIATION_RETAIN);
    objc_setAssociatedObject(view, &PresentingViewAddress, self, OBJC_ASSOCIATION_RETAIN);
    if (animated) {
        [self doAlertAnimate:view complete:complete];
    }else{
        view.center = self.window.center;
    }
}

- (UIView *)presentedView{
    UIView * view =  objc_getAssociatedObject(self, &PresentedViewAddress);
    return view;
}

- (void)dismissPresentedView:(BOOL)animated complete:(void(^)()) complete{
    UIView * view =  objc_getAssociatedObject(self, &PresentedViewAddress);
    if (animated) {
        [self doHideAnimate:view complete:complete];
    }else{
        [view removeFromSuperview];
        [self cleanAssocaiteObject];
    }
}

- (void)hideSelf:(BOOL)animated complete:(void(^)()) complete{
    UIView * baseView =  objc_getAssociatedObject(self, &PresentingViewAddress);
    if (!baseView) {
        return;
    }
    [baseView dismissPresentedView:animated complete:complete];
    [self cleanAssocaiteObject];
}


- (void)onPressBkg:(id)sender{
    [self dismissPresentedView:YES complete:nil];
}

#pragma mark - Animation
- (void)doAlertAnimate:(UIView*)view complete:(void(^)()) complete{
    CGRect bounds = view.bounds;
    // 放大
    CABasicAnimation *scaleAnimation = [CABasicAnimation animationWithKeyPath:@"bounds"];
    scaleAnimation.duration  = AnimateDuartion;
    scaleAnimation.fromValue = [NSValue valueWithCGRect:CGRectMake(0, 0, 1, 1)];
    scaleAnimation.toValue   = [NSValue valueWithCGRect:bounds];
    
    // 移动
    CABasicAnimation *moveAnimation = [CABasicAnimation animationWithKeyPath:@"position"];
    moveAnimation.duration   = AnimateDuartion;
    moveAnimation.fromValue  = [NSValue valueWithCGPoint:[self.superview convertPoint:self.center toView:nil]];
    moveAnimation.toValue    = [NSValue valueWithCGPoint:self.window.center];
    
    CAAnimationGroup *group = [CAAnimationGroup animation];
    group.beginTime                = CACurrentMediaTime();
    group.duration                = AnimateDuartion;
    group.animations            = [NSArray arrayWithObjects:scaleAnimation,moveAnimation,nil];
    group.timingFunction        = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    group.fillMode                = kCAFillModeForwards;
    group.removedOnCompletion    = NO;
    group.autoreverses            = NO;
    
    [self hideAllSubView:view];
    
    [view.layer addAnimation:group forKey:@"groupAnimationAlert"];
    
    __weak UIView * wself = self;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(AnimateDuartion * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        view.layer.bounds    = bounds;
        view.layer.position  = wself.superview.center;
        [wself showAllSubView:view];
        if (complete) {
            complete();
        }
    });
    
}

- (void)doHideAnimate:(UIView*)alertView complete:(void(^)()) complete{
    if (!alertView) {
        return;
    }
    // 缩小
    CABasicAnimation *scaleAnimation = [CABasicAnimation animationWithKeyPath:@"bounds"];
    scaleAnimation.duration = AnimateDuartion;
    scaleAnimation.toValue  = [NSValue valueWithCGRect:CGRectMake(0, 0, 1, 1)];
    
    CGPoint position   = self.center;
    // 移动
    CABasicAnimation *moveAnimation = [CABasicAnimation animationWithKeyPath:@"position"];
    moveAnimation.duration = AnimateDuartion;
    moveAnimation.toValue  = [NSValue valueWithCGPoint:[self.superview convertPoint:self.center toView:nil]];
    
    CAAnimationGroup *group   = [CAAnimationGroup animation];
    group.beginTime           = CACurrentMediaTime();
    group.duration            = AnimateDuartion;
    group.animations          = [NSArray arrayWithObjects:scaleAnimation,moveAnimation,nil];
    group.timingFunction      = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    group.fillMode            = kCAFillModeForwards;
    group.removedOnCompletion = NO;
    group.autoreverses        = NO;
    
    
    alertView.layer.bounds    = self.bounds;
    alertView.layer.position  = position;
    alertView.layer.needsDisplayOnBoundsChange = YES;
    
    [self hideAllSubView:alertView];
    alertView.backgroundColor = [UIColor clearColor];
    
    [alertView.layer addAnimation:group forKey:@"groupAnimationHide"];
    
    __weak UIView * wself = self;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(AnimateDuartion * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [alertView removeFromSuperview];
        [wself cleanAssocaiteObject];
        [wself showAllSubView:alertView];
        if (complete) {
            complete();
        }
    });
}


static char *HideViewsAddress = "hideViewsAddress";
- (void)hideAllSubView:(UIView*)view{
    for (UIView * subView in view.subviews) {
        NSMutableArray *array = [[NSMutableArray alloc] init];
        if (subView.hidden) {
            [array addObject:subView];
        }
        objc_setAssociatedObject(self, &HideViewsAddress, array, OBJC_ASSOCIATION_RETAIN);
        subView.hidden = YES;
    }
}

- (void)showAllSubView:(UIView*)view{
    NSMutableArray *array = objc_getAssociatedObject(self,&HideViewsAddress);
    for (UIView * subView in view.subviews) {
        subView.hidden = [array containsObject:subView];
    }
}

- (void)cleanAssocaiteObject{
    objc_setAssociatedObject(self,&PresentedViewAddress,nil,OBJC_ASSOCIATION_RETAIN);
    objc_setAssociatedObject(self,&PresentingViewAddress,nil,OBJC_ASSOCIATION_RETAIN);
    objc_setAssociatedObject(self,&HideViewsAddress,nil, OBJC_ASSOCIATION_RETAIN);
}

@end
