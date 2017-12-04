//  DrawView.h
//  测试画图demo
//
//  Created by apple on 2017/11/23.
//  Copyright © 2017年 lxd. All rights reserved.
//

#import <UIKit/UIKit.h>
@class XDDrawData;
@interface XDDrawView : UIView
// 点和点直径的间隔
@property (nonatomic, assign) CGFloat grWidth;
// 柱子的宽度
@property (nonatomic, assign) CGFloat polyWidth;
// 中间图标区域(不包含坐标轴)的边距
@property (nonatomic, assign) UIEdgeInsets chartMargin;
/** 折线的颜色 */
@property (nonatomic, strong) UIColor *brokenLineColor;
/** 折线上文字的颜色 */
@property (nonatomic, strong) UIColor *brokenLineTextColor;
/** 柱子上文字的颜色 */
@property (nonatomic, strong) UIColor *histogramTextColor;
/** 柱子的颜色 */
@property (nonatomic, strong) UIColor *histogramColor;
/** 是否要画曲线 */
@property (nonatomic, assign) BOOL isCurve;
/** 折线的粗细 */
@property (nonatomic, assign) CGFloat lineWidth;

@property (nonatomic, strong) XDDrawData *data;
/** 折线数组 */
@property (nonatomic, strong) NSMutableArray *lineValueArray;
@end
