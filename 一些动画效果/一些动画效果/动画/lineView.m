//
//  lineView.m
//  一些动画效果
//
//  Created by XF on 16/8/30.
//  Copyright © 2016年 XF. All rights reserved.
//

#import "lineView.h"

@implementation lineView

-(instancetype)initLineViewWithColor:(UIColor *)color
{
    if (self = [super init])
    {
        self.frame = CGRectMake(0, 0, WIDTH, HEIGHT);
        self.backgroundColor = [UIColor colorWithRed:1.0f green:1.0f blue:1.0f alpha:0.5f];
        self.alpha = 0.0;
        [self createUI];
    }
    return self;
}
-(void)createUI
{
    CGFloat boxX = (WIDTH-80)/2;
    for (int i = 0; i<3; i++)
    {
        UIView * view = [[UIView alloc]initWithFrame:CGRectMake(boxX+30*i, (HEIGHT-30)/2, 20, 30)];
        view.backgroundColor = [UIColor grayColor];
        [self addSubview:view];
    }
    [self animationWithItemIndex:0];
}
//-(void)startAnimation
//{
//    for (int i = 0; i<self.subviews.count; i++)
//    {
//        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//             [self animationWithItemIndex:i];
//        });
//       
//    }
//}
-(void)animationWithItemIndex:(NSInteger)index
{
    int lodIndext;
    
    if (index == 0)
    {
        lodIndext = 2;
    }
    else
    {
        lodIndext = (int)index-1;
    }
    __block CGRect frame = self.subviews[index].frame;
    __block CGRect lodFrame = self.subviews[lodIndext].frame;
    
    
    CGFloat boxY = (HEIGHT-30)/2;
    
    
    
    [UIView animateWithDuration:0.1 delay:0.0 options:lodFrame.size.height<boxY?UIViewAnimationOptionCurveEaseIn:UIViewAnimationOptionCurveEaseOut animations:^
    {
        frame.size.height = frame.origin.y<boxY?30:50;
        frame.origin.y = frame.origin.y<boxY?boxY:boxY-10;
        self.subviews[index].backgroundColor = frame.origin.y<boxY?[UIColor whiteColor]:[UIColor grayColor];
        self.subviews[index].frame = frame;
        
    } completion:^(BOOL finished)
    {
        int intdext;
        if (index == 2)
        {
            intdext = 0;
        }
        else
        {
            intdext = (int)index+1;
        }
        [self animationWithItemIndex:intdext];
    }];
}
@end
