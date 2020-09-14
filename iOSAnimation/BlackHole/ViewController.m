//
//  ViewController.m
//  BlackHole
//
//  Created by doushuyao on 2020/9/12.
//  Copyright © 2020 com.opooc.DesignPatterns. All rights reserved.
//

#import "ViewController.h"
#import "HoleView.h"

@interface ViewController ()
@property (nonatomic,strong) HoleView *holeView;
@property (nonatomic,strong) NSTimer *timeer;
@property (nonatomic,assign) NSInteger index;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //这里不会直接触发drawRect:(CGRect)rect;
    //因为没有 设置frame、也没有addsubView，更没有主动调用
    self.holeView = [HoleView new];
    //这里会调
    self.holeView.frame = UIScreen.mainScreen.bounds;
    //设置青色
    self.holeView.backgroundColor = [UIColor cyanColor];
     [self.view addSubview:self.holeView];
    //
    self.index = 0;
    self.timeer = [NSTimer scheduledTimerWithTimeInterval:1.0f/30 target:self selector:@selector(refushImage) userInfo:nil repeats:true];

}

- (void)refushImage{
    //这里这样调用 主要是为了传半径的大小
    [self.holeView blackHoleIncrease:self.index];
    self.index +=1 ;
}

@end
