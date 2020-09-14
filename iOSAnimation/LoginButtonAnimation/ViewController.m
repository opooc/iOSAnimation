//
//  ViewController.m
//  LoginButtonAnimation
//
//  Created by doushuyao on 2020/9/13.
//  Copyright © 2020 com.opooc.DesignPatterns. All rights reserved.
//

#import "ViewController.h"
#include "ButtonView.h"
@interface ViewController ()

@property (nonatomic,strong,readwrite)ButtonView *buttonview1;
@property (nonatomic,strong,readwrite)ButtonView *buttonview2;
@property (nonatomic,strong,readwrite)ButtonView *buttonview3;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.buttonview1 = [[ButtonView alloc]initWithFrame:CGRectMake(100, 150, 210, 70)];
    self.buttonview2 = [[ButtonView alloc]initWithFrame:CGRectMake(100, 275, 210, 70)];
    self.buttonview3 = [[ButtonView alloc]initWithFrame:CGRectMake(100, 400, 210, 70)];
    
    UITapGestureRecognizer *singleTap1 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(viewAction1)];
    UITapGestureRecognizer *singleTap2 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(viewAction2)];
    UITapGestureRecognizer *singleTap3 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(viewAction3)];
    
    [self.buttonview1 addGestureRecognizer:singleTap1];
    [self.buttonview2 addGestureRecognizer:singleTap2];
    [self.buttonview3 addGestureRecognizer:singleTap3];
    
    [self.view addSubview:self.buttonview1];
    [self.view addSubview:self.buttonview2];
    [self.view addSubview:self.buttonview3];
}

- (void)viewAction1{
    [self.buttonview1 startAnimation];
}
- (void)viewAction2{
    [self.buttonview2 startAnimation];
}
- (void)viewAction3{
    [self.buttonview3 startAnimation];
}
@end
