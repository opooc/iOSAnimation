//
//  ViewController.m
//  LineChartAnimation
//
//  Created by doushuyao on 2020/9/14.
//  Copyright © 2020 com.opooc.DesignPatterns. All rights reserved.
//

#import "ViewController.h"
#import "BazierView.h"
#import "LineChartView.h"
#import "BarChartView.h"

@interface ViewController ()
@property (nonatomic,strong,readwrite) LineChartView *lineChartView1;
@property (nonatomic,strong,readwrite) BarChartView *barChartView1;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //1.使用贝瑟尔曲线
    //[self drawBazierView];
    
    //2.折线/柱状图
    //2.1添加动态折线图表
    [self drawLineChartView];
    //2.2添加动态柱状图
    [self drawBarChartView];
    //2.3加个按钮用来开启动画
    [self addDrawChartButton];
    
    //3.设置平面图;
    [self addAxes];
}

- (void)drawBarChartView{
    self.barChartView1 = [[BarChartView alloc]initWithFrame:CGRectMake(0, self.view.bounds.size.height * 0.5, self.view.bounds.size.width, self.view.bounds.size.height)];
    [self.view addSubview:self.barChartView1];
}

- (void)addAxes{
    
    //line
    for (int i = 0 ; i < 5; i++) {
        NSString *xAxesTitle = [NSString stringWithFormat:@"SEP%d",i];
        //书上50太长了
        UILabel *xAxesLabel  = [[UILabel alloc]initWithFrame:CGRectMake(20+i*70, 300, 50 ,20)];
        xAxesLabel.text = xAxesTitle;
        [self.view addSubview:xAxesLabel];
    }
    for (int i = 0 ; i < 5; i++) {
        NSString *yAxesTitle = [NSString stringWithFormat:@"%d",10-i*2];
        //书上50太长了
        UILabel *yAxesLabel  = [[UILabel alloc]initWithFrame:CGRectMake(20 , 120+ (i-1)*35, 20 ,20)];
        yAxesLabel.text = yAxesTitle;
        [self.view addSubview:yAxesLabel];
    }
    
    //Bar
    for (int i = 0 ; i < 5; i++) {
        NSString *xAxesTitle = [NSString stringWithFormat:@"SEP%d",i];
        //书上50太长了
        UILabel *xAxesLabel  = [[UILabel alloc]initWithFrame:CGRectMake(40+i*70, 600, 50 ,20)];
        xAxesLabel.text = xAxesTitle;
        [self.view addSubview:xAxesLabel];
    }
    
}

//2.1.1开启动画
- (void) drawChart{
    [self.lineChartView1 drawLineChart];
    [self.barChartView1 drawLineChart];
}
//2.2加个按钮用来开启动画
- (void) addDrawChartButton{
    UIButton *bt_line = [[UIButton alloc]initWithFrame:CGRectMake((self.view.frame.size.width-100)/2, 20, 100, 50)];
    [bt_line setTitle:@"Line Chart" forState:UIControlStateNormal];
    //这里的颜色解耦一下，书上直接上升到宏了。
    [bt_line setTitleColor:[UIColor colorWithDisplayP3Red:77.0/255.0 green: 186.0/255.0 blue:122.0/255.0 alpha:1.0] forState:UIControlStateNormal];
    [bt_line addTarget:self action:@selector(drawChart) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:bt_line];
}

//2.1使用动态折线图表
- (void) drawLineChartView{
    self.lineChartView1 = [[LineChartView alloc]initWithFrame:self.view.bounds];
    [self.view addSubview:self.lineChartView1];
}
//1使用贝瑟尔曲线
- (void)drawBazierView{
    //书上位置是(0,self.view.bounds.size.height/2.0f)
    BazierView *bazierView = [[BazierView alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height)];
    [self.view addSubview:bazierView];
}

@end
