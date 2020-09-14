//
//  ViewController.m
//  GraduallyFrame
//
//  Created by doushuyao on 2020/9/12.
//  Copyright © 2020 com.opooc.DesignPatterns. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (nonatomic,strong,readwrite) UIImageView *imageView;
@property (nonatomic,strong)NSTimer *timer;
@property (nonatomic,assign)NSInteger index;

//使用CADisplayLink
@property (strong, nonatomic) CADisplayLink *displayLink;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.imageView = [[UIImageView alloc]initWithFrame:UIScreen.mainScreen.bounds];
    self.imageView.contentMode = UIViewContentModeScaleAspectFit;
    [self.view addSubview:self.imageView];
    self.index = 0;
    
    self.displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(refushImage)];
    //控制是否暂停
    self.displayLink.paused = NO;
    [self.displayLink addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSRunLoopCommonModes];
    
//    使用NSTimer
//    self.timer = [NSTimer scheduledTimerWithTimeInterval:0.1f target:self selector:@selector(refushImage) userInfo:nil repeats:true];
    
    // Do any additional setup after loading the view.
}


//CADisplayLink和NStimer 定时调用此方法
- (void) refushImage{
    NSString *imageName = [NSString stringWithFormat:@"%ld",self.index];
    self.imageView.image = [UIImage imageNamed:imageName];
    self.index += 1;
    if (self.index  == 67) {
//        [self.timer invalidate];
        self.displayLink.paused = YES;
    }
}

@end
