//
//  XDDrawData.h
//  测试画图demo
//
//  Created by apple on 2017/11/27.
//  Copyright © 2017年 lxd. All rights reserved.
//

#import <UIKit/UIKit.h>
@class XDDrawDataSet;
@interface XDDrawData : NSObject
@property (nonatomic, strong)NSArray<NSString *> *xLabels;
@property (nonatomic, strong)NSArray<NSString *> *yLabels;
@property (nonatomic, strong)NSArray<XDDrawDataSet *> *dataSets;
@property (nonatomic)CGFloat yMaxNum;//y 轴最大值

@property (nonatomic, assign)CGFloat groupSpace;// 大的分组的间距
@property (nonatomic, assign)CGFloat itemSpace;// 单个组内的每个 item 间距
@property (nonatomic, assign, readonly)BOOL isGrouped;

@property (nonatomic, strong)UIColor *xLabelTextColor;
@property (nonatomic, strong)UIColor *yLabelTextColor;
@property (nonatomic, assign)CGFloat xLabelFontSize;
@property (nonatomic, assign)CGFloat yLabelFontSize;

- (instancetype)initWithDataSets:(NSArray<XDDrawDataSet *> *)dataSets;
@end

@interface XDDrawDataSet : NSObject
@property (nonatomic, strong)NSArray<NSNumber *> *yValues;
@property (nonatomic, strong)NSString *label;// legend label

@property (nonatomic, strong)UIColor *barColor;
//@property (nonatomic, strong)UIColor *BarbackGroudColor;

- (instancetype)initWithYValues:(NSArray<NSNumber *> *)yValues label:(NSString *)label;

@end
