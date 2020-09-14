//
//  ViewController.m
//  waterRipple
//
//  Created by doushuyao on 2020/9/13.
//  Copyright © 2020 com.opooc.DesignPatterns. All rights reserved.
//

#import "ViewController.h"
#import "WaterButton.h"
@interface ViewController ()

@property (nonatomic,strong,readwrite) WaterButton *waterButton;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.waterButton = [[WaterButton alloc]initWithFrame:CGRectMake(20, 230, self.view.frame.size.width - 20*2, 50)];
    [self.waterButton setTitle:@"登录" forState:UIControlStateNormal];
    [self.waterButton addTarget:self action:@selector(loginAction:AndEvent:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.waterButton];
    
    // Do any additional setup after loading the view.
}
- (void)loginAction:(UIButton *)sender AndEvent:(UIEvent*)event{
   
    WaterButton *waterSender = (WaterButton*)sender;
    [waterSender startButtonAnimationWithButton:waterSender AndEvent:event];
}

@end
