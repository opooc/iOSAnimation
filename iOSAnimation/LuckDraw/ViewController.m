//
//  ViewController.m
//  LuckDraw
//
//  Created by doushuyao on 2020/9/7.
//  Copyright © 2020 com.opooc.DesignPatterns. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (nonatomic, strong, readwrite) UIImageView *imageView;
@property (nonatomic, assign, readwrite) NSInteger index;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.index = 1;
    // Do any additional setup after loading the view.
    self.imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 400, 400)];
    self.imageView.center = self.view.center;
    self.imageView.image =  [UIImage imageNamed:@"turntable"];
    [self.view addSubview:self.imageView];
}

- (void)viewWillAppear:(BOOL)animated {
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDidStopSelector:@selector(animationEnd)];
    [UIView setAnimationDuration:0.01f];
    self.imageView.transform = CGAffineTransformMakeRotation(M_PI_2);
    [UIView commitAnimations];
}

- (void)animationEnd {
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDidStopSelector:@selector(animationEnd)];
    [UIView setAnimationDuration:0.01f];
    self.index = self.index + 1;
    self.imageView.transform = CGAffineTransformMakeRotation(M_PI_2*self.index);
    [UIView commitAnimations];
}

@end
