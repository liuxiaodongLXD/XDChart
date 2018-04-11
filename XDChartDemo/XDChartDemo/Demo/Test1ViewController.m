//
//  Test1ViewController.m
//  柱状折线上下限
//
//  Created by apple on 2017/11/23.
//  Copyright © 2017年 lxd. All rights reserved.
//

#import "Test1ViewController.h"
#import "XDDrawChatView.h"
#import "XDDrawData.h"
@interface Test1ViewController ()
@end

@implementation Test1ViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithRed:241/255.0 green:241/255.0 blue:241/255.0 alpha:1.0];
    // 1.创建
    XDDrawChatView *drawChatView = [[XDDrawChatView alloc] init];
    drawChatView.frame = CGRectMake(0, 100, [UIScreen mainScreen].bounds.size.width, 250);
    // 2.设置相关属性
    drawChatView.chartMargin = UIEdgeInsetsMake(15, 0, 25, 0);
    // 2.1 设置柱子的宽度
    drawChatView.polyWidth = 15;
    // 2.2 设置动画时间(不设置默认时间2秒)
    drawChatView.duration = 2.0;
    // 2.3 设置是否需要动画效果
    drawChatView.isNeedAnima = YES;
    
    drawChatView.isCurve = YES;
    // 3.创建每一组的数据模型
    XDDrawDataSet *set = [[XDDrawDataSet alloc] initWithYValues:@[@10,@40,@70,@180,@250,@111,@0] label:@"送检数量"];
    [set setBarColor:[UIColor colorWithRed:245.0 / 255.0 green:94.0 / 255.0 blue:78.0 / 255.0 alpha:1.0f]];
    XDDrawDataSet *set1 = [[XDDrawDataSet alloc] initWithYValues:@[@40,@50,@0,@100,@120,@101,@0] label:@"检验数量"];
    [set1 setBarColor:[UIColor colorWithRed:77.0 / 255.0 green:186.0 / 255.0 blue:122.0 / 255.0 alpha:1.0f]];
    XDDrawDataSet *set2 = [[XDDrawDataSet alloc] initWithYValues:@[@20,@80,@40,@0,@140,@101,@0] label:@"审核数"];
    [set2 setBarColor:[UIColor colorWithRed:17.0 / 255.0 green:16.0 / 255.0 blue:202.0 / 255.0 alpha:1.0f]];
    XDDrawData *data = [[XDDrawData alloc] initWithDataSets:@[set,set1,set2]];
    // 4.赋值数据
    drawChatView.data = data;
    // 5.设置组与组直接的间隔
    data.itemSpace = 0;
    data.groupSpace = 20;
    // 6.X轴数据
    data.xLabels = @[@"一月",@"二月",@"三月",@"四月",@"五月",@"六月",@"七月"];
    // 7.折线数组（为空即不画折线）
    XDDrawDataSet *brokenLineset = [[XDDrawDataSet alloc] initWithYValues:@[@45,@50,@69,@141,@142,@143,@140] label:@""];
    [brokenLineset setBarColor:[UIColor colorWithRed:145.0 / 255.0 green:24.0 / 255.0 blue:78.0 / 255.0 alpha:1.0f]];
    XDDrawData *brokenLinedata = [[XDDrawData alloc] initWithDataSets:@[brokenLineset]];
    brokenLinedata.groupSpace = 80;
    drawChatView.brokenLineData = brokenLinedata;
    // 8.上下限数据
    drawChatView.limitValueArray = [NSMutableArray arrayWithArray:@[@42,@83,@120]];
    NSMutableArray *tuliArray = [[NSMutableArray alloc] init];
    
    XDDrawDataSet *tuliSet = [[XDDrawDataSet alloc] init];
    tuliSet.label = @"上限";
    tuliSet.barColor = [UIColor redColor];
    XDDrawDataSet *tuliSet1 = [[XDDrawDataSet alloc] init];
    tuliSet1.label = @"报警";
    tuliSet1.barColor = [UIColor blueColor];
    XDDrawDataSet *tuliSet2 = [[XDDrawDataSet alloc] init];
    tuliSet2.label = @"下限";
    tuliSet2.barColor = [UIColor greenColor];
    [tuliArray addObject:tuliSet];
    [tuliArray addObject:tuliSet1];
    [tuliArray addObject:tuliSet2];
    drawChatView.limitTuLiValueArray = tuliArray;
    // 9. 折线的宽度
    drawChatView.lineWidth = 2;
    // 10.展示出来
    [drawChatView show];
    [self.view addSubview:drawChatView];
}


@end
