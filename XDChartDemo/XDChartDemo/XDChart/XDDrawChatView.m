//
//  DrawChatView.m
//  github地址：https://github.com/liuxiaodongLXD/XDChart
//
//  Created by apple on 2017/11/24.
//  Copyright © 2017年 lxd. All rights reserved.
//
// 图例所占的高度
#define XDLegendViewH 30
#import "XDDrawChatView.h"
#import "XDDrawView.h"
#import "XDDrawData.h"
#import "XDLegendView.h"
@interface  XDDrawChatView()
@property (nonatomic, strong) NSArray *textArray;
@property (nonatomic, strong) NSArray *yValue;
@property (nonatomic, strong) NSArray *histogramValueArray;
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UIScrollView *legendViewScrollView;
@property (nonatomic, strong, readwrite) XDLegendView *legendView;
/** <##> */
@property (nonatomic, strong) NSMutableArray *legendViewDataArray;

@end
@implementation XDDrawChatView
- (NSMutableArray *)legendViewDataArray{
    if (!_legendViewDataArray) {
        _legendViewDataArray = [NSMutableArray array];
    }
    return _legendViewDataArray;
}
- (CGFloat)polyWidth{
    if (_polyWidth == 0) {
        _polyWidth = 20;
    }
    return _polyWidth;
}
// 默认动画时间设置2秒
- (CGFloat)duration{
    if (_duration == 0) {
        _duration = 2;
    }
    return _duration;
}
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        self.isDrawColumnar = YES;
    }
    return self;
}
- (void)show{
    // 判断柱状图是否有数据
    if (_data != nil) {
        if (_data.xLabels.count == 0) {
            NSLog(@"柱状图x轴值不能为空");
            return;
        }
        [self setupLegendView];
    }else if (_brokenLineData != nil){
        if (_brokenLineData.xLabels.count == 0) {
            NSLog(@"折线图x轴值不能为空");
            return;
        }
        [self setupBrokenLineLegendView];
    }
    if (_data != nil && _brokenLineData != nil) {
        NSLog(@"将已柱状图的为准");
//        [self setupBrokenLineLegendView];
    }
    [self creatDrawView];
}
/**
 创建画布
 */
- (void)creatDrawView {
    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, XDLegendViewH, self.frame.size.width, self.frame.size.height - XDLegendViewH)];
    _scrollView.showsHorizontalScrollIndicator = NO;
    [self addSubview:_scrollView];
    CGFloat dViewW = 0;
    CGFloat groWidth = 0;
    if (self.isNdg) { // 正态分布图
        // 计算得每一组的宽度
        if (_data != nil) {
            XDDrawDataSet *set = _data.dataSets[0];
            self.polyWidth = [UIScreen mainScreen].bounds.size.width / set.yValues.count - _data.itemSpace;
            groWidth = [UIScreen mainScreen].bounds.size.width / set.yValues.count;
        }
        if (_brokenLineData != nil){ // 折线的数据
            XDDrawDataSet *set = _brokenLineData.dataSets[0];
            self.ndgLineWidth = [UIScreen mainScreen].bounds.size.width / set.yValues.count;
        }
        dViewW = [UIScreen mainScreen].bounds.size.width;
    }else{ // 普通的图
        if (_data != nil) {
            groWidth = self.polyWidth * _data.dataSets.count + (_data.dataSets.count - 1) * _data.itemSpace + _data.groupSpace;
            dViewW = _data.xLabels.count * groWidth + self.chartMargin.left;
        }else if (_brokenLineData != nil){
            groWidth = self.polyWidth * _brokenLineData.dataSets.count + (_brokenLineData.dataSets.count - 1) * _brokenLineData.itemSpace + _brokenLineData.groupSpace;
            dViewW = _brokenLineData.xLabels.count * groWidth + self.chartMargin.left;
        }
        if (dViewW < [UIScreen mainScreen].bounds.size.width) {
            dViewW = [UIScreen mainScreen].bounds.size.width;
        }
    }
    XDDrawView *dView = [[XDDrawView alloc] initWithFrame:CGRectMake(0, 0, dViewW, self.frame.size.height - XDLegendViewH)];
    [dView setPolyWidth:self.polyWidth];
    [dView setGrWidth:groWidth];
    [dView setBrokenLineColor:self.brokenLineColor];
    [dView setBrokenLineTextColor:self.brokenLineTextColor];
    [dView setChartMargin:self.chartMargin];
    [dView setIsCurve:self.isCurve];
    [dView setLineWidth:self.lineWidth];
    [dView setData:self.data];
    [dView setDuration:self.duration];
    [dView setIsNeedAnima:self.isNeedAnima];
    [dView setLineValueArray:self.lineValueArray];
    [dView setIsDrawColumnar:self.isDrawColumnar];
    [dView setLimitValueArray:self.limitValueArray];
    [dView setBrokenLineData:self.brokenLineData];
    [dView setLimitTuLiValueArray:self.limitTuLiValueArray];
    [dView setNdgLineWidth:self.ndgLineWidth];
    [dView setIsNdg:self.isNdg];
    [_scrollView addSubview:dView];
    
    _scrollView.contentSize = CGSizeMake(dView.frame.size.width, 0);
    
}
// 创建折线图图例
- (void)setupBrokenLineLegendView{
    [_brokenLineData.dataSets enumerateObjectsUsingBlock:^(XDDrawDataSet * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        XDLewLegendViewData *data = [XDLewLegendViewData new];
        data.color = obj.barColor;
        data.label = obj.label;
        [self.legendViewDataArray addObject:data];
    }];
    [self.limitTuLiValueArray enumerateObjectsUsingBlock:^(XDDrawDataSet *  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        XDLewLegendViewData *data = [XDLewLegendViewData new];
        data.color = obj.barColor;
        data.label = obj.label;
        [self.legendViewDataArray addObject:data];
        
    }];
    self.legendView.data = self.legendViewDataArray;
    if (CGPointEqualToPoint(_legendView.center, CGPointZero)) {
        _legendView.center = CGPointMake(self.bounds.size.width-_legendView.bounds.size.width/2, _legendView.bounds.size.height/2);
    }
}
// 创建柱状图图例
- (void)setupLegendView{
    [_data.dataSets enumerateObjectsUsingBlock:^(XDDrawDataSet * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        XDLewLegendViewData *data = [XDLewLegendViewData new];
        data.color = obj.barColor;
        data.label = obj.label;
        [self.legendViewDataArray addObject:data];
    }];
    self.legendView.data = self.legendViewDataArray;
    if (CGPointEqualToPoint(_legendView.center, CGPointZero)) {
        _legendView.center = CGPointMake(self.bounds.size.width-_legendView.bounds.size.width/2, _legendView.bounds.size.height/2);
    }
}

/**
 画图例的get方法
 @return 图例view
 */
- (XDLegendView *)legendView{
    if (!_legendView) {
        self.legendViewScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, XDLegendViewH)];
        self.legendViewScrollView.showsHorizontalScrollIndicator = NO;
        _legendView = [[XDLegendView alloc] init];
        __block CGFloat textWidth = 0;
        [self.legendViewDataArray enumerateObjectsUsingBlock:^(XDLewLegendViewData * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            NSString *legendText = obj.label;
            CGSize size = [legendText sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:10]}];
            
            textWidth = textWidth+size.width + RectWidth + 2*Rect_TextMargin + Rect_TextMargin;
        }];
        CGFloat legendViewX = 0;
        if (textWidth < [UIScreen mainScreen].bounds.size.width) {
            legendViewX = [UIScreen mainScreen].bounds.size.width - textWidth;
        }
        self.legendView.frame = CGRectMake(legendViewX, 0, textWidth, XDLegendViewH);
        self.legendView.textWidth = textWidth;
        [self.legendViewScrollView addSubview:_legendView];
        [self addSubview:self.legendViewScrollView];
        self.legendViewScrollView.contentSize = _legendView.frame.size;
    }
    return _legendView;
}
@end
