//  DrawView.h
//  测试画图demo
//
//  Created by apple on 2017/11/23.
//  Copyright © 2017年 lxd. All rights reserved.
//

#import <UIKit/UIKit.h>
@class XDDrawData;
@interface XDDrawView : UIView
/** 是不是正态分布图 */
@property (nonatomic, assign) BOOL isNdg;
// 折线点和点之间的间隔
@property (nonatomic, assign) CGFloat ndgLineWidth;
// 组间隔(包含间隔)
@property (nonatomic, assign) CGFloat grWidth;
// 柱子的宽度(单柱子，没有间隔)
@property (nonatomic, assign) CGFloat polyWidth;
// 中间图标区域(不包含坐标轴)的边距
@property (nonatomic, assign) UIEdgeInsets chartMargin;
/** 折线的颜色 */
@property (nonatomic, strong) UIColor *brokenLineColor;
/** 折线上文字的颜色 */
@property (nonatomic, strong) UIColor *brokenLineTextColor;
/** 是否要画曲线 */
@property (nonatomic, assign) BOOL isCurve;
/** 是否要画柱状图 */
@property (nonatomic, assign) BOOL isDrawColumnar;
/** 折线的粗细 */
@property (nonatomic, assign) CGFloat lineWidth;
/** 动画时间 */
@property (nonatomic, assign) CGFloat duration;
/** 是否需要动画效果 */
@property (nonatomic, assign) BOOL isNeedAnima;

@property (nonatomic, strong) XDDrawData *data;
/** 折线图的数据模型 */
@property (nonatomic, strong) XDDrawData *brokenLineData;
/** 折线数组 */
@property (nonatomic, strong) NSMutableArray *lineValueArray;
/** 上下限数组 */
@property (nonatomic, strong) NSMutableArray *limitValueArray;
/** 上下限图例数组 */
@property (nonatomic, strong) NSMutableArray *limitTuLiValueArray;
@end
