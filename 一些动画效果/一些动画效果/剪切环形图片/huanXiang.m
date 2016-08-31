//
//  imageView.m
//  一些动画效果
//
//  Created by XF on 16/8/31.
//  Copyright © 2016年 XF. All rights reserved.
//

#import "huanXiang.h"

@implementation huanXiang

-(instancetype)init
{
    if (self = [super init])
    {
        
        self.frame = CGRectMake(0, 0, WIDTH, HEIGHT);
        self.backgroundColor = [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.5];
        _image = [UIImage imageNamed:@"01.jpg"];
        
        [self changeImage];
        
        //圆形
        [self circleImage];
        
        //裁剪
        [self getClearRectImage:_image];
        
        _imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 40,100,100)];
       
        _imageView.image = _image;
        [self addSubview:_imageView];
    }
    return self;
}

//圆形图片裁剪
-(UIImage *)circleImage
{
    //开启图形上下文
    UIGraphicsBeginImageContextWithOptions(_image.size, NO, 0);
    //描述圆形路径
    UIBezierPath * path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(0, 0, _image.size.width, _image.size.height)];
    //设置裁剪区域
    [path addClip];
    
    //画图
    [_image drawAtPoint:CGPointZero];
    //取出图片
    _image = UIGraphicsGetImageFromCurrentImageContext();
    //关闭上下文
    UIGraphicsEndImageContext();
    
    return _image;
    
}

//制作环形图片
-(UIImage *)getClearRectImage:(UIImage *)image
{
    UIGraphicsBeginImageContextWithOptions(_image.size, NO, 0.0f);
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    [_image drawAtPoint:CGPointZero];
    
    CGFloat bigRaduis = _image.size.width/5;
    CGRect cirleRect = CGRectMake(_image.size.width/2-bigRaduis, _image.size.height/2-bigRaduis, bigRaduis*2, bigRaduis*2);
    
    CGContextAddEllipseInRect(ctx, cirleRect);
    CGContextClip(ctx);
    CGContextClearRect(ctx, cirleRect);
    
    _image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return _image;
}

//长方形转成正方形
-(void)changeImage
{
    CGFloat imageWidth = _image.size.width;
    CGFloat imageHeight = _image.size.height;
    
    CGRect rect;
    if (imageWidth>imageHeight)
    {
        rect = CGRectMake(0, 0, imageHeight, imageHeight);
    }
    else if (imageWidth == imageHeight)
    {
        rect = CGRectMake(0, 0, imageWidth, imageHeight);
    }
    else
    {
        rect = CGRectMake(0, 0, imageWidth, imageWidth);
    }
    
    
    CGImageRef squareImageRef = CGImageCreateWithImageInRect(_image.CGImage, rect);
    
    CGRect squareImageBounds = CGRectMake(0, 0,CGImageGetWidth(squareImageRef), CGImageGetHeight(squareImageRef));
    
    UIGraphicsBeginImageContext(squareImageBounds.size);
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextDrawImage(context, squareImageBounds, squareImageRef);
    
    _image = [UIImage imageWithCGImage:squareImageRef];
    UIGraphicsEndImageContext();
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
