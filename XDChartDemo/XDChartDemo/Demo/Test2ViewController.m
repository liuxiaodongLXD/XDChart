//
//  Test2ViewController.m
//  单组柱状
//
//  Created by apple on 2018/4/11.
//  Copyright © 2018年 lxd. All rights reserved.
//
#import "Test2ViewController.h"
#import "XDDrawChatView.h"
#import "XDDrawData.h"
@interface Test2ViewController ()
@end

@implementation Test2ViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithRed:241/255.0 green:241/255.0 blue:241/255.0 alpha:1.0];
    // 1.创建
    XDDrawChatView *drawChatView = [[XDDrawChatView alloc] init];
    drawChatView.frame = CGRectMake(0, 100, [UIScreen mainScreen].bounds.size.width, 250);
    // 2.设置相关属性
    drawChatView.chartMargin = UIEdgeInsetsMake(15, 0, 25, 0);
    // 2.1 设置柱子的宽度
    drawChatView.polyWidth = 25;
    // 2.2 设置动画时间(不设置默认时间2秒)
    drawChatView.duration = 2.0;
    // 2.3 设置是否需要动画效果
    drawChatView.isNeedAnima = YES;
    
    drawChatView.isCurve = YES;
    // 3.创建每一组的数据模型
    XDDrawDataSet *set = [[XDDrawDataSet alloc] initWithYValues:@[@10,@40,@70,@180,@250,@111,@0,@2] label:@"送检数量"];
    [set setBarColor:[UIColor colorWithRed:245.0 / 255.0 green:94.0 / 255.0 blue:78.0 / 255.0 alpha:1.0f]];
    XDDrawData *data = [[XDDrawData alloc] initWithDataSets:@[set]];
    // 4.赋值数据
    drawChatView.data = data;
    // 5.设置组与组直接的间隔
    data.itemSpace = 0;
    data.groupSpace = 20;
    // 6.X轴数据
    data.xLabels = @[@"一月",@"二月",@"三月",@"四月",@"五月",@"六月",@"七月",@"八月"];
    [drawChatView show];
    [self.view addSubview:drawChatView];
}


@end
