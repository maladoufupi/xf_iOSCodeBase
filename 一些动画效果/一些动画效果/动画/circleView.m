//
//  circleView.m
//  一些动画效果
//
//  Created by XF on 16/8/30.
//  Copyright © 2016年 XF. All rights reserved.
//

#import "circleView.h"

@implementation circleView

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        [self createColor];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self createColor];
    }
    return self;
}

-(void)createColor
{
    self.color  = [UIColor orangeColor];
}

-(void)drawRect:(CGRect)rect
{
    [self drawCircle:CGPointMake(CGRectGetMidX(rect), CGRectGetMidY(rect))];
}
- (void)drawCircle:(CGPoint)location
{
    CGContextRef ctx= UIGraphicsGetCurrentContext();
    CGRect bounds = [self bounds];
    
    CGPoint center;
    center.x = bounds.origin.x + bounds.size.width / 2.0;
    center.y = bounds.origin.y + bounds.size.height / 2.0;
    CGContextSaveGState(ctx);
    
    CGContextSetLineWidth(ctx, 5);
    CGContextSetFillColorWithColor(ctx, _color.CGColor);
    CGContextAddArc(ctx, location.x, location.y, MIN(bounds.size.height, bounds.size.width)/2.0, 0.0, M_PI*2, YES);
    CGContextFillPath(ctx);
}
@end
