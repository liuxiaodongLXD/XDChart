//
//  DrawChatView.h
//  测试画图demo
//
//  Created by apple on 2017/11/24.
//  Copyright © 2017年 lxd. All rights reserved.
//

#import <UIKit/UIKit.h>
@class XDDrawData;
@interface XDDrawChatView : UIView
/** 柱子的宽度 */
@property (nonatomic, assign) CGFloat polyWidth;
/** 中间图标区域(不包含坐标轴)的边距 */
@property (nonatomic, assign) UIEdgeInsets chartMargin;
/** 折线的颜色 */
@property (nonatomic, weak) UIColor *brokenLineColor;
/** 折线上文字的颜色 */
@property (nonatomic, strong) UIColor *brokenLineTextColor;
/** 是否要画曲线 */
@property (nonatomic, assign) BOOL isCurve;
/** 是否需要动画效果 */
@property (nonatomic, assign) BOOL isNeedAnima;
/** 折线的粗细 */
@property (nonatomic, assign) CGFloat lineWidth;
/** 动画时间 */
@property (nonatomic, assign) CGFloat duration;
/** 每一组里的数据模型 */
@property (nonatomic, strong) XDDrawData *data;
/** 折线数组 */
@property (nonatomic, strong) NSMutableArray *lineValueArray;
/** 展示出来 */
- (void)show;

@end
