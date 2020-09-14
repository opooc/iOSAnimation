//
//  ViewController.m
//  GIFgogogo~
//
//  Created by doushuyao on 2020/9/12.
//  Copyright © 2020 com.opooc.DesignPatterns. All rights reserved.
//

#import "ViewController.h"
#import <MobileCoreServices/MobileCoreServices.h>
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self showGIF];
}
- (void)showGIF{
    NSMutableArray<UIImage *> *images = [NSMutableArray array];
    //遍历所有图片，并扔到一个数组中
    for (int i = 0 ; i< 66 ; i++) {
        NSString *imagePath = [NSString stringWithFormat:@"image/%d.png",i];
        UIImage *image      = [UIImage imageNamed:imagePath];
        [images addObject:image];
    }
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:self.view.bounds];
    imageView.contentMode  = UIViewContentModeCenter;
    [self.view addSubview:imageView];
    
    imageView.animationImages      = images;
    imageView.animationDuration    = 5;
    imageView.animationRepeatCount =1;
    [imageView startAnimating];
    //停在最后一张 
    imageView.image = [UIImage imageNamed:@"image/66.png"];
    
}

- (void) UnCode{
    //1.从文件中拿到图片，扔到iamgeArr中
    NSMutableArray *imageArr = [NSMutableArray array];
    for (int i = 0 ; i < 66; i++) {
        NSString *imagePath = [NSString stringWithFormat:@"image/%d.png",i];
        UIImage *image = [UIImage imageNamed:imagePath];
        [imageArr addObject:image];
    }
    
    //2.在Document目录创建gif文件
    //2.1找目录，设置最终路径
    NSArray *docs       =  NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *doucumentDirectoryStr = docs[0];
    NSString *imagePath = [NSString stringWithFormat:@"%@/myPlane.gif",doucumentDirectoryStr];
    //2.2转成cf格式的 URL
    CFURLRef url = CFURLCreateWithFileSystemPath(kCFAllocatorDefault, (CFStringRef)imagePath, kCFURLPOSIXPathStyle, false);
    //2.3CGImageDestinationCreateWithURL是创建目标对象,并设置kUTTypeGIF代表GIF类型,是mobileCoreServices框架中的
    CGImageDestinationRef  destination = CGImageDestinationCreateWithURL(url, kUTTypeGIF, imageArr.count, nil);
    
    //3设置gif图片的属性
    //3.1设置图片的属性和图片属性字典
    //设置图片的展示时间间隔
    NSDictionary *cgimagePropertiesDic = [NSDictionary dictionaryWithObject:@(0.1f) forKey:(NSString *)kCGImagePropertyGIFDelayTime];
    //进行二层字典封装把图片的展示时间间隔作为value，设置图片属性字典
    NSDictionary *cgimagePropertiesDestDic = [NSDictionary dictionaryWithObject:cgimagePropertiesDic forKey:(NSString *)kCGImagePropertyGIFDictionary];
    //3.2为gif添加每一帧
    for (UIImage *cgimage in imageArr) {
        //设置到哪个gif目标，把什么图片设置过去，怎么设置
        CGImageDestinationAddImage(destination, cgimage.CGImage, (CFDictionaryRef)cgimagePropertiesDestDic);
    }
    //3.3设置每一帧的图片属性
    //把属性用字典装起来
    NSMutableDictionary *gifPropertiesDic = [NSMutableDictionary dictionary];
    //设置格式为RGB,还可以设置为黑白
    [gifPropertiesDic setValue:(NSString *)kCGImagePropertyColorModelRGB forKey:(NSString *)kCGImagePropertyColorModel];
    //设置图片颜色深度,一般彩色的图片设置为16，24,或者32，16是只要两个维度，24是要三个维度，32是在四个维度加上了Alpha； 黑白图像一般为8，即2的8次方 = 256种颜色
    [gifPropertiesDic setValue:@(16) forKey:(NSString *)kCGImagePropertyDepth];
    //设置执行次数
    [gifPropertiesDic setValue:@(1) forKey:(NSString *)kCGImagePropertyGIFLoopCount];
    //将图片属性字典添加到一个字典中
    NSDictionary *gifDictionaryDestDic = [NSDictionary dictionaryWithObject:gifPropertiesDic forKey:(NSString *)kCGImagePropertyGIFDictionary];
    
    //4.完成构建,把上面的二层图片属性字典，对应到gif文件中
    CGImageDestinationSetProperties(destination, (CFDictionaryRef)gifDictionaryDestDic);
    CGImageDestinationFinalize(destination);
    //5.释放目标对象
    CFRelease(destination);
}


//分解图片扔入目录
-(void) Decode{
        //这里NSData不能用URL来加载，因为没有什么用~
    //    NSURL *gifURL = [NSURL URLWithString:[[NSBundle mainBundle]pathForResource:@"plane.gif" ofType:@""]];
        NSString *gifURLStr = [[NSBundle mainBundle]pathForResource:@"plane.gif" ofType:@""];
        NSData *gifData     = [NSData dataWithContentsOfFile:gifURLStr];
    //    将data转成可以被imageIO识别的数据类型.
        CFDataRef gifCFData = (__bridge CFDataRef) gifData;
        CGImageSourceRef gifDataSource = CGImageSourceCreateWithData(gifCFData, nil);
    //    得到个数
        NSInteger size =  CGImageSourceGetCount(gifDataSource);
        for (int i = 0 ; i<size; i++) {
            //取到某一帧的动画
            CGImageRef cgImage = CGImageSourceCreateImageAtIndex(gifDataSource, i, nil);
            //转成UIImage
            UIImage *image     = [UIImage imageWithCGImage:cgImage scale:UIScreen.mainScreen.scale orientation:UIImageOrientationUp];
            //转成PNG的data
            NSData *imageData  = UIImagePNGRepresentation(image);
            //找目录
            NSArray *docs       =  NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
            NSString *doucumentDirectoryStr = docs[0];
            //设置路径
            NSString *imagePath = [NSString stringWithFormat:@"%@/%d.png",doucumentDirectoryStr,i];
            //把图像数据写入文件夹
            [imageData writeToURL:[NSURL fileURLWithPath:imagePath] options:NSDataWritingAtomic error:nil];
            NSLog(@"%@",imagePath);
        }
}

@end
