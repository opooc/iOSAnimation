//
//  ViewController.m
//  3DFirstMeet
//
//  Created by doushuyao on 2020/9/14.
//  Copyright © 2020 com.opooc.DesignPatterns. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 400, 300)];
    imageView.center       = self.view.center;
    imageView.image        = [UIImage imageNamed:@"image.jpg"];
    imageView.contentMode  = UIViewContentModeScaleAspectFit;
    imageView.layer.anchorPoint = CGPointMake(0.5, 0.5);//设定锚点位置,控制了旋转轴,范围 （0-1）0.5代表了中心轴
    [self.view addSubview:imageView];
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:4.0f];
    
    //创建个3D矩阵，直接操作
    CATransform3D transform = CATransform3DIdentity;
    transform.m22           = 0.5;
    imageView.layer.transform = CATransform3DScale(transform, 1, 1, 1);
    
//    imageView.layer.transform = CATransform3DMakeRotation(M_PI * 0.5, 0, 1, 0);
    
    [UIView commitAnimations];
}


@end
