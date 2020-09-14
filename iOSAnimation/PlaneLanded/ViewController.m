//
//  ViewController.m
//  PlaneLanded
//
//  Created by doushuyao on 2020/9/7.
//  Copyright © 2020 com.opooc.DesignPatterns. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (nonatomic,strong,readwrite) UIImageView *airportImageView;
@property (nonatomic,strong,readwrite) UIImageView *planeImageView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.airportImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"Airport"]];
    self.planeImageView   = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"Plane"]];
    
    self.airportImageView.frame = self.view.bounds;
    self.planeImageView.frame   = CGRectMake(100, 100, 50, 50);
    
    self.airportImageView.contentMode = UIViewContentModeScaleAspectFit;
    self.planeImageView.contentMode   = UIViewContentModeScaleAspectFit;
    
    [self.view addSubview:self.airportImageView];
    [self.view addSubview:self.planeImageView];
}

- (void) viewWillAppear:(BOOL)animated{
    [UIView animateKeyframesWithDuration:2.0f delay:0 options:UIViewKeyframeAnimationOptionCalculationModeCubic animations:^{
//方案1
//        self.planeImageView.frame = CGRectMake(300, 300, 50, 50);
//方案2
        [UIView addKeyframeWithRelativeStartTime:0.0f relativeDuration:0.5f animations:^{
            self.planeImageView.frame = CGRectMake(300, 100, 30, 30);
        }];
//
        [UIView addKeyframeWithRelativeStartTime:0.5f relativeDuration:0.5f animations:^{
            self.planeImageView.frame = CGRectMake(300, 300, 100, 100);
        }];
        
    } completion:^(BOOL finished) {
        
    }];
//    [UIView commitAnimations];
}
@end
