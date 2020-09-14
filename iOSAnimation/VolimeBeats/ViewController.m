//
//  ViewController.m
//  VolimeBeats
//
//  Created by doushuyao on 2020/9/14.
//  Copyright © 2020 com.opooc.DesignPatterns. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (nonatomic,strong,readwrite) NSMutableArray *colorArray;
@property (nonatomic,strong,readwrite) NSMutableArray *layerArray;
@property (nonatomic,assign,readwrite) int audioBarNum;
@property (nonatomic,strong,readwrite) CAGradientLayer *gradientLayer;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setcolorArray];
    self.view.backgroundColor = [UIColor blackColor];
    
    self.audioBarNum = 15;
    CGFloat h = 150;
    CGFloat w = (self.view.frame.size.width - 10)/(CGFloat)self.audioBarNum ;
    CGFloat x = 20;
    CGFloat y = 50;

    self.layerArray = [NSMutableArray array];
    for (int i = 0 ; i<self.audioBarNum; i++) {
        //w - x代表 每次的间隔都是x
        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(x + w*i, y, w-x , h)];
        [self.view addSubview:view];
        //初始化layer,并放到数组中
        self.gradientLayer            = [CAGradientLayer new];
        self.gradientLayer.frame      = view.bounds;
        self.gradientLayer.startPoint = CGPointMake(0, 0);
        self.gradientLayer.endPoint   = CGPointMake(0, 1);
        [view.layer addSublayer:self.gradientLayer];
        //这个数组主要是为了设置定时器。
        [self.layerArray addObject:self.gradientLayer];
    }

    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:0.4f target:self selector:@selector(colorChange) userInfo:nil repeats:true];

}
- (void)colorChange{
    for (id myLayer in self.layerArray) {
        NSLog(@"");
        CAGradientLayer *layer = (CAGradientLayer *)myLayer;
        //随机取一种颜色
        int index = (int)arc4random_uniform(11);
        //随机取颜色
        UIColor *color  = [self.colorArray objectAtIndex:index];
        layer.locations = @[@(0.1f),@(0.0f)];
        layer.colors    = @[(id)[UIColor clearColor].CGColor,(id)color.CGColor];
        //开始律动吧~
        CABasicAnimation *gradientAnimation = [CABasicAnimation new];
        
        gradientAnimation.keyPath   = @"locations";
        CGFloat beginValue          = arc4random_uniform(11)/10.0;
        gradientAnimation.fromValue = @[@(beginValue),@(beginValue)];
        gradientAnimation.toValue   = @[@(1.0f),@(1.0f)];
        gradientAnimation.duration  = 0.4f;
        [layer addAnimation:gradientAnimation forKey:nil];
    }
}

- (void)setcolorArray {
    self.colorArray = [NSMutableArray array];
    UIColor *color1 = [UIColor colorWithDisplayP3Red:255.0 / 255.0 green: 127.0 / 255.0 blue: 79.0 / 255.0  alpha:1.0];
    UIColor *color2 = [UIColor colorWithDisplayP3Red:138.0 / 255.0 green: 206.0 / 255.0 blue: 245.0 / 255.0 alpha: 1.0];
    UIColor *color3 = [UIColor colorWithDisplayP3Red:216.0 / 255.0 green: 114.0 / 255.0 blue: 213.0 / 255.0 alpha: 1.0];
    UIColor *color4 = [UIColor colorWithDisplayP3Red:51.0 / 255.0 green: 207.0 / 255.0 blue: 48.0 / 255.0 alpha: 1.0];
    UIColor *color5 = [UIColor colorWithDisplayP3Red:102.0 / 255.0 green: 150.0 / 255.0 blue: 232.0 / 255.0 alpha: 1.0];
    UIColor *color6 = [UIColor colorWithDisplayP3Red:255.0 / 255.0 green: 105.0 / 255.0 blue: 177.0 / 255.0 alpha: 1.0];
    UIColor *color7 = [UIColor colorWithDisplayP3Red:187.0 / 255.0 green: 56.0 / 255.0 blue: 201.0 / 255.0 alpha: 1.0];
    UIColor *color8 = [UIColor colorWithDisplayP3Red:255.0 / 255.0 green: 163.0 / 255.0 blue: 0.0 / 255.0 alpha: 1.0];
    UIColor *color9 = [UIColor colorWithDisplayP3Red:203.0 / 255.0 green: 93.0 / 255.0 blue: 92.0 / 255.0 alpha: 1.0];
    UIColor *color10 = [UIColor colorWithDisplayP3Red:61.0 / 255.0  green: 226.0 / 255.0 blue: 210.0 / 255.0 alpha: 1.0];
    UIColor *color11 = [UIColor colorWithDisplayP3Red:25.0 / 255.0  green: 146.0 / 255.0 blue: 255.0 / 255.0 alpha: 1.0];
    [self.colorArray addObjectsFromArray:@[color1,color2,color3,color4,color5,color6,color7,color8,color9,color10,color11]];
}

@end
