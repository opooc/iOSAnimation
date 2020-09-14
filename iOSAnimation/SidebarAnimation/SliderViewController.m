//
//  SliderViewController.m
//  iOSAnimation
//
//  Created by doushuyao on 2020/9/14.
//  Copyright © 2020 com.opooc.DesignPatterns. All rights reserved.
//

#import "SliderViewController.h"
#import <Accelerate/Accelerate.h> // 使用vImage API进行模糊 ||也可以使用Core Image进行模糊

#define DEVICE_SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height
#define DEVICE_SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width

@interface SliderViewController ()

@property (nonatomic,strong,readwrite) UIView *blurView;//模糊视图
@property (nonatomic,strong,readwrite) UIView *contentView; // 侧栏视图

@end

@implementation SliderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.blurView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, DEVICE_SCREEN_WIDTH, DEVICE_SCREEN_HEIGHT)];
    [self.view addSubview:self.blurView];
    
    self.contentView = [[UIView alloc]initWithFrame:CGRectMake(-DEVICE_SCREEN_WIDTH*0.60, 0, DEVICE_SCREEN_WIDTH*0.60, DEVICE_SCREEN_HEIGHT)];
    self.contentView.backgroundColor = [UIColor colorWithDisplayP3Red:255.0 / 255.0 green:127.0 / 255.0 blue: 79.0 / 255.0 alpha:1.0];
    [self.view addSubview:self.contentView];
    
}

//侧栏显示动画
- (void)sliderLeftViewAnimStart{
    UIView *winView = [[[[UIApplication sharedApplication] keyWindow] rootViewController]view];
    UIImage *winImage = [self imageFromUIView2:winView];
    self.blurView.layer.contents   = (id)[self blurimageFromImage: winImage].CGImage;
    self.view.alpha = 1.0f;
    [UIView animateWithDuration:0.5f animations:^{
        self.contentView.frame = CGRectMake(0, 0, DEVICE_SCREEN_WIDTH*0.6, DEVICE_SCREEN_HEIGHT);
        self.contentView.alpha = 0.9;
    } completion:^(BOOL finished) {
        
    }];
}


//侧栏消失动画
- (void) sliderVCDismiss{

    [UIView animateWithDuration:0.5f animations:^{
        self.contentView.frame = CGRectMake(-DEVICE_SCREEN_WIDTH*0.6, 0, DEVICE_SCREEN_WIDTH*0.6, DEVICE_SCREEN_HEIGHT);
        self.contentView.alpha = 0.9f;
    } completion:^(BOOL finished) {
        self.contentView.alpha = 0.0f;
    }];
}

//UIView转化为UIImage
//1.0这个方法转换出来的图片  文字图片会变模糊
- (UIImage *)imageFromUIView:(UIView *)view {

   UIGraphicsBeginImageContext(view.bounds.size);
   [view.layer renderInContext:UIGraphicsGetCurrentContext()];
   UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
   UIGraphicsEndImageContext();
   return image;

}

//2.0使用该方法不会模糊，根据屏幕密度计算
- (UIImage *)imageFromUIView2:(UIView *)view {
    
    UIImage *imageRet = [[UIImage alloc]init];
    //UIGraphicsBeginImageContextWithOptions(区域大小, 是否是非透明的, 屏幕密度);
    UIGraphicsBeginImageContextWithOptions(view.frame.size, YES, [UIScreen mainScreen].scale);
    [view.layer renderInContext:UIGraphicsGetCurrentContext()];
    imageRet = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return imageRet;
    
}

//UIImage设置蒙版模糊效果
- (UIImage *)blurimageFromImage:(UIImage *)image{
    
    int blurRadix          = 7;//模糊半径
    
    CGImageRef img               = image.CGImage;
    CGDataProviderRef inProvider = CGImageGetDataProvider(img); //获取数据信息，转成CFData
    CFDataRef bitmapdata         = CGDataProviderCopyData(inProvider);//获取数据信息，转成CFData
    
    //使用Accekerate
    vImage_Buffer inputBuffer,outBuffer;
    inputBuffer.data     = (void*)CFDataGetBytePtr(bitmapdata);//这里直接转空指针
    inputBuffer.width    = CGImageGetWidth(img);
    inputBuffer.height   = CGImageGetHeight(img);
    inputBuffer.rowBytes = CGImageGetBytesPerRow(img);
    
    void *pixelBuffer;
    pixelBuffer = malloc(CGImageGetBytesPerRow(img) * CGImageGetHeight(img));

    outBuffer.data     = pixelBuffer;
    outBuffer.width    = CGImageGetWidth(img);
    outBuffer.height   = CGImageGetHeight(img);
    outBuffer.rowBytes = CGImageGetBytesPerRow(img);
    
    vImageBoxConvolve_ARGB8888(&inputBuffer, &outBuffer, nil, 0, 0, blurRadix, blurRadix, nil, kvImageEdgeExtend);
    
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    

    //书上最后是image.cgImage!.bitmapInfo.rawValue
    //我只能拿到CGBitmapInfo info = CGImageGetBitmapInfo(image.CGImage);
    //最后使用kCGImageAlphaNoneSkipLast
    CGContextRef ctx = CGBitmapContextCreate(outBuffer.data, outBuffer.width, outBuffer.height, 8, outBuffer.rowBytes, colorSpace, kCGImageAlphaNoneSkipLast);
    
    CGImageRef imageRef = CGBitmapContextCreateImage (ctx);
    UIImage *imagenew   = [UIImage imageWithCGImage:imageRef];
    
    free(pixelBuffer);
    return imagenew;
}
@end
