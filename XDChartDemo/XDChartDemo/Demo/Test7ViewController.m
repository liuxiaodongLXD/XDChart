//
//  Test7ViewController.m
//  XDChartDemo
//
//  Created by apple on 2018/4/11.
//  Copyright © 2018年 lxd. All rights reserved.
//

#import "Test7ViewController.h"

@interface Test7ViewController ()

@end

@implementation Test7ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    UILabel *textLabel = [[UILabel alloc] init];
    textLabel.numberOfLines = 0;
    textLabel.text = @"正态分布图即支持柱状数据和折线数据并不对等的情况，折线数据要远远多于柱状数据，此时X轴将以柱状个数为准，从而形成正态分布图【已经封装好，此处没给出例子】";
    textLabel.frame = CGRectMake(10, 100, 300, 200);
    [self.view addSubview:textLabel];
}

@end
