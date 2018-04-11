//
//  Test6ViewController.m
//  折线和上下限
//
//  Created by apple on 2018/4/11.
//  Copyright © 2018年 lxd. All rights reserved.
//

#import "Test6ViewController.h"
#import "XDDrawChatView.h"
#import "XDDrawData.h"
@interface Test6ViewController ()
@end

@implementation Test6ViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithRed:241/255.0 green:241/255.0 blue:241/255.0 alpha:1.0];
    // 1.创建
    XDDrawChatView *drawChatView = [[XDDrawChatView alloc] init];
    drawChatView.frame = CGRectMake(0, 100, [UIScreen mainScreen].bounds.size.width, 250);
    // 2.设置相关属性
    drawChatView.chartMargin = UIEdgeInsetsMake(15, 0, 25, 0);
    // 2.1 设置动画时间(不设置默认时间2秒)
    drawChatView.duration = 2.0;
    // 2.2 设置是否需要动画效果
    drawChatView.isNeedAnima = YES;
    drawChatView.isCurve = YES;
    // 3.折线数组（为空即不画折线）
    XDDrawDataSet *brokenLineset = [[XDDrawDataSet alloc] initWithYValues:@[@45,@50,@69,@141,@142,@143,@140] label:@"趋势"];
    [brokenLineset setBarColor:[UIColor colorWithRed:145.0 / 255.0 green:24.0 / 255.0 blue:78.0 / 255.0 alpha:1.0f]];
    XDDrawData *brokenLinedata = [[XDDrawData alloc] initWithDataSets:@[brokenLineset]];
    brokenLinedata.xLabels = @[@"一月",@"二月",@"三月",@"四月",@"五月",@"六月",@"七月"];
    brokenLinedata.groupSpace = 80;
    drawChatView.brokenLineData = brokenLinedata;
    // 4.上下限数据
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
    // 5. 折线的宽度
    drawChatView.lineWidth = 2;
    // 6.展示出来
    [drawChatView show];
    [self.view addSubview:drawChatView];
}


@end
