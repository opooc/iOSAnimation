//
//  ViewController.m
//  SidebarAnimation
//
//  Created by doushuyao on 2020/9/14.
//  Copyright © 2020 com.opooc.DesignPatterns. All rights reserved.
//

#import "ViewController.h"
#import "SliderViewController.h"
//这里就不放PFC了
#define DEVICE_SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height
#define DEVICE_SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width

@interface ViewController ()

@property (nonatomic,strong,readwrite) SliderViewController *sliderVC;

@end

@implementation ViewController

int flag = 0;//用来控制隐藏还是弹出 0代表隐藏 1 代表弹出状态

- (void)viewDidLoad {
    [super viewDidLoad];
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, DEVICE_SCREEN_WIDTH, DEVICE_SCREEN_HEIGHT)];
    imageView.image        = [UIImage imageNamed:@"login.png"];
    [self.view addSubview:imageView];
    //y:200正好
    UIButton *loginButton  = [[UIButton alloc]initWithFrame:CGRectMake(20, 200, self.view.frame.size.width - 20*2, 50)];
    loginButton.backgroundColor = [UIColor colorWithDisplayP3Red:50/255.0 green:185/255.0 blue:170/255.0 alpha:1.0];
    [loginButton setTitle:@"登陆" forState:UIControlStateNormal];
    [self.view addSubview:loginButton];
    
    self.sliderVC = [SliderViewController new];
    self.sliderVC.view.frame = CGRectMake(0, 0, DEVICE_SCREEN_WIDTH, DEVICE_SCREEN_HEIGHT);
    [self.sliderVC.view setHidden: YES];
    [self.view addSubview:self.sliderVC.view];
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    if (flag == 0) {
        [self.sliderVC.view setHidden: NO];
        [self.sliderVC sliderLeftViewAnimStart];
        flag = 1;
    }else if (flag == 1){
        [self.sliderVC.view setHidden: YES];
        [self.sliderVC sliderVCDismiss];
        flag = 0;
    }
    
   
}
@end
