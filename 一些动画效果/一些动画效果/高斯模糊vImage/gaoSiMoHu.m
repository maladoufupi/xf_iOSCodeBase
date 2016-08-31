//
//  gaoSiMoHu.m
//  一些动画效果
//
//  Created by XF on 16/8/31.
//  Copyright © 2016年 XF. All rights reserved.
//

#import "gaoSiMoHu.h"

@implementation gaoSiMoHu
-(instancetype)init
{
    if (self = [super init])
    {
        self.frame = CGRectMake(0, 0, WIDTH,HEIGHT);
        self.backgroundColor = [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.5];
        
        UIImage * image= [UIImage imageNamed:@"touxiangMin.jpeg"];
        CGRect frame = [self changImageWidthAndHeightWithImage:image];
        image = [self createImage:image andBlurleve:0.9];
        UIImageView * imageView = [[UIImageView alloc]initWithFrame:frame];
        imageView.image = image;
        
        [self addSubview:imageView];
    }
    return self;
}

-(CGRect)changImageWidthAndHeightWithImage:(UIImage *)image
{
    CGFloat imageWidth = image.size.width;
    CGFloat imageHeight = image.size.height;
    
    CGFloat widthBiLi = WIDTH/imageWidth;
    CGFloat heightBiLi = HEIGHT/imageHeight;
    //如果图片的宽大于屏幕宽
    if (imageWidth>=WIDTH)
    {
        imageWidth  = WIDTH;
        imageHeight = imageHeight*widthBiLi;
    }
    else if (imageHeight>= HEIGHT)
    {
        imageHeight = HEIGHT;
        imageWidth = imageWidth*heightBiLi;
    }
   
    CGRect rect = CGRectMake(0, 0, imageWidth, imageHeight);
    return rect;
}

-(UIImage *)createImage:(UIImage *)image andBlurleve:(CGFloat)leve
{
    if (leve<0.f || leve>1.f)
    {
        leve = 0.5;
    }
    
    int boxSize = (int)(leve*100);
    
    boxSize = boxSize - (boxSize%2)+1;
    
    //转换图片类型
    CGImageRef img = image.CGImage;
    
    //图片的开始缓冲区和结束缓冲区
    vImage_Buffer inBuffer, outBuffer;
    
    //图片的报错
    vImage_Error error;
    
    //像素缓冲
    void * pixelBuffer;
    
    //CG数据提供者                       返回"图片数据提供者"
    CGDataProviderRef inProvider = CGImageGetDataProvider(img);
    //数据                       返回一个指定数据提供者的副本，如果不能获得完整副本则返回NULL
    CFDataRef inBitmapData = CGDataProviderCopyData(inProvider);
    
    //开始缓冲区的宽度
    inBuffer.width = CGImageGetWidth(img);
    //开始缓冲区的高度
    inBuffer.height = CGImageGetHeight(img);
    //开始缓冲区像素所占字节数
    inBuffer.rowBytes = CGImageGetBytesPerRow(img);
    //指针指向开始缓冲区
    inBuffer.data = (void *)CFDataGetBytePtr(inBitmapData);
    //动态分配内存获得两个参数的乘积      返回图片的字节数          返回图片的高度
    pixelBuffer = malloc(CGImageGetBytesPerRow(img) * CGImageGetHeight(img));
    
    if (pixelBuffer == NULL)
    {
        NSLog(@"NO pixelbuffer");
    }
    
    //指针指向结束缓冲区
    outBuffer.data = pixelBuffer;
    //结束缓冲区的宽度
    outBuffer.width = CGImageGetWidth(img);
    //结束缓冲区的高度
    outBuffer.height = CGImageGetHeight(img);
    //结束缓冲区像素所占字节数
    outBuffer.rowBytes = CGImageGetBytesPerRow(img);
    
    //开始高斯模糊处理
    error = vImageBoxConvolve_ARGB8888(&inBuffer, &outBuffer, NULL, 0, 0, boxSize, boxSize, NULL, kvImageEdgeExtend);
    
    if (error)
    {
        NSLog(@"error from convolution %ld",error);
        
    }
    
    //                             创建一个DeviceRGB颜色空间
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    //创建一个图形上下文  结束高斯模糊处理
    CGContextRef ctx = CGBitmapContextCreate(outBuffer.data, outBuffer.width, outBuffer.height, 8, outBuffer.rowBytes, colorSpace,kCGImageAlphaNoneSkipLast);
    
    //生成一个经过高斯模糊 包含图形上下文的位图
    CGImageRef imageRef = CGBitmapContextCreateImage(ctx);
    //转换为图片对象
    UIImage * returnImage = [UIImage imageWithCGImage:imageRef];
    //释放图形上下文
    CGContextRelease(ctx);
    //释放颜色空间
    CGColorSpaceRelease(colorSpace);
    //释放 被malloc动态分配的内存
    free(pixelBuffer);
    //释放数据提供者副本
    CFRelease(inBitmapData);
    //释放颜色空间
    CGColorSpaceRelease(colorSpace);
    //释放形成高斯模糊的位图
    CGImageRelease(imageRef);
    
    return returnImage;
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [UIView animateWithDuration:0.3 animations:^{
        self.alpha = 0.0;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}
@end
