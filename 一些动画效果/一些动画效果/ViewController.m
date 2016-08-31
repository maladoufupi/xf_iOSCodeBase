//
//  ViewController.m
//  一些动画效果
//
//  Created by XF on 16/8/30.
//  Copyright © 2016年 XF. All rights reserved.
//

#import "ViewController.h"
#import "lineView.h"
#import "roundView.h"
#import "huanXiang.h"
#import "gaoSiMoHu.h"
#import "corrugatedView.h"
@interface ViewController ()
@property(nonatomic,strong)NSArray * dataArray;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createUI];
}
-(void)createUI
{
    _dataArray = @[@"线",@"圆",@"扩散圆",@"环形图片",@"高斯模糊"];
    _table = [[UITableView alloc]initWithFrame: CGRectMake(0, 20, WIDTH, HEIGHT-20)];
    _table.delegate = self;
    _table.dataSource = self;
    [self.view addSubview:_table];
    
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataArray.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return HEIGHT*kUIHeightTwo(60);
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * ID =@"XF";
    
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    cell.textLabel.text = _dataArray[indexPath.row];
    cell.textLabel.textColor = [UIColor blackColor];
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0)
    {
        lineView * lin = [[lineView alloc]initLineViewWithColor:[UIColor grayColor]];
        [[UIApplication sharedApplication].keyWindow addSubview:lin];
        lin.alpha = 1.0;
    }
    else if (indexPath.row == 1)
    {
        roundView * view = [[roundView alloc]init];
        [[UIApplication sharedApplication].keyWindow addSubview:view];
        
    }
    else if (indexPath.row == 2)
    {
        corrugatedView * view = [[corrugatedView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT)];
        view.color = [UIColor orangeColor];
        [[UIApplication sharedApplication].keyWindow addSubview:view];
    }
    else if (indexPath.row == 3)
    {
        huanXiang * huanxingView= [[huanXiang alloc]init];
        [[UIApplication sharedApplication].keyWindow addSubview:huanxingView];
    }
    else if (indexPath.row == 4)
    {
        gaoSiMoHu * gaosi = [[gaoSiMoHu alloc]init];
        [[UIApplication sharedApplication].keyWindow addSubview:gaosi];
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
