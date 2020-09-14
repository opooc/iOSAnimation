//
//  ViewController.m
//  LoginButtonAnimationEffect
//
//  Created by doushuyao on 2020/9/7.
//  Copyright © 2020 com.opooc.DesignPatterns. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (nonatomic, strong, readwrite) UIButton *loginButton;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIImageView *bgview = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"login"]];
    bgview.frame = self.view.frame;
    [self.view addSubview:bgview];

    _loginButton = [[UIButton alloc]initWithFrame:CGRectMake(-394, 200, self.view.frame.size.width - 20 * 2, 50)];
    _loginButton.backgroundColor = [UIColor colorWithDisplayP3Red:50 / 255.0 green:185 / 255.0 blue:170 / 255.0 alpha:1.0];
    [_loginButton setTitle:@"登录" forState:UIControlStateNormal];
    [self.view addSubview:_loginButton];
}

- (void)viewWillAppear:(BOOL)animated {
     //UiView已经过时了，不再适合目前的场景需求
     /*
     [UIView beginAnimations:nil context:nil];
     [UIView setAnimationDuration:1];
     _loginButton.frame = CGRectMake(20, _loginButton.frame.origin.y, _loginButton.frame.size.width, _loginButton.frame.size.height);
     [UIView commitAnimations]; ]
     */
    
    
    //UIViewPropertyAnimator是iOS10+后面最新的类
    /*
     typedef NS_ENUM(NSInteger, UIViewAnimationCurve) {
         UIViewAnimationCurveEaseInOut,         // slow at beginning and end
         UIViewAnimationCurveEaseIn,            // slow at beginning
         UIViewAnimationCurveEaseOut,           // slow at end
         UIViewAnimationCurveLinear,
     };
     */
    UIViewPropertyAnimator *animator = [[UIViewPropertyAnimator alloc]initWithDuration:1.0 curve:UIViewAnimationCurveEaseIn animations:^{
        self.loginButton.frame = CGRectMake(20, self.loginButton.frame.origin.y, self.loginButton.frame.size.width, self.loginButton.frame.size.height);
    }];
    [animator startAnimation];
}

@end
