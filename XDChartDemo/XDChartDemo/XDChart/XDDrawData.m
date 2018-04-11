//
//  XDDrawData.m
//  github地址：https://github.com/liuxiaodongLXD/XDChart
//
//  Created by apple on 2017/11/27.
//  Copyright © 2017年 lxd. All rights reserved.
//

#import "XDDrawData.h"

@implementation XDDrawData
- (instancetype)initWithDataSets:(NSArray<XDDrawDataSet *> *)dataSets{
    self = [super init];
    if (!self) return nil;
    
    _dataSets = dataSets;
    _groupSpace = 10;
    _itemSpace = 5;
    return self;
}
@end

@implementation XDDrawDataSet

- (instancetype)initWithYValues:(NSArray<NSNumber *> *)yValues label:(NSString *)label{
    self = [super init];
    if (!self) return nil;
    
    _yValues = yValues;
    _label = label;
    _barColor = [UIColor colorWithRed:77.0 / 255.0 green:186.0 / 255.0 blue:122.0 / 255.0 alpha:1.0f];
    
    return self;
}
@end
