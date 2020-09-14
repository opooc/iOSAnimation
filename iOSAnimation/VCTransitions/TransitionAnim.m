//
//  TransitionAnim.m
//  iOSAnimation
//
//  Created by doushuyao on 2020/9/14.
//  Copyright © 2020 com.opooc.DesignPatterns. All rights reserved.
//

#import "TransitionAnim.h"

@interface TransitionAnim()

@end

@implementation TransitionAnim



- (void)animateTransition:(nonnull id<UIViewControllerContextTransitioning>)transitionContext {
    UIViewController *fromVc = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *tomVc  = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    CGRect fromVCRect = [transitionContext initialFrameForViewController:fromVc];
    CGRect toVCRect   = CGRectMake(0, fromVCRect.size.height*2, fromVCRect.size.width, fromVCRect.size.height);
    
    UIView *fromView = fromVc.view;
    UIView *toView   = tomVc.view;
    
    fromView.frame = fromVCRect;
    toView.frame   = toVCRect;
    
    [transitionContext.containerView addSubview:fromView];
    [transitionContext.containerView addSubview:toView];
    
    [UIView animateWithDuration:2.0f animations:^{
        toView.frame = fromVCRect;
        toView.alpha = 1;
    } completion:^(BOOL finished) {
        [transitionContext completeTransition:YES];
    }];
    
}

- (NSTimeInterval)transitionDuration:(nullable id<UIViewControllerContextTransitioning>)transitionContext {
    return 2;//转场时间
}

@end
