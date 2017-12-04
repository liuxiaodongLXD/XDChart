//
//  DrawChatView.m
//  测试画图demo
//
//  Created by apple on 2017/11/24.
//  Copyright © 2017年 lxd. All rights reserved.
//

#import "XDDrawChatView.h"
#import "XDDrawView.h"
#import "XDDrawData.h"
#import "XDLegendView.h"
@interface  XDDrawChatView()
/** <##> */
@property (nonatomic, strong) NSArray *textArray;
/** <##> */
@property (nonatomic, strong) NSArray *yValue;
/** <##> */
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
- (UIEdgeInsets)chartMargin{
    if (_chartMargin.left == 0) {
        _chartMargin.left = 10;
    }else if (_chartMargin.bottom < 25){
        _chartMargin.bottom = 25;
    }else if (_chartMargin.top < 20){
        _chartMargin.top = 20;
    }
    return _chartMargin;
}
- (CGFloat)polyWidth{
    if (_polyWidth == 0) {
        _polyWidth = 20;
    }
    return _polyWidth;
}
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}
- (void)show{
    if (_data.xLabels.count == 0) {
        NSLog(@"x轴值不能为空");
        return;
    }
    [self creatDrawView];
    [self setupLegendView];
}
/**
   创建画布
 */
- (void)creatDrawView {
    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    _scrollView.showsHorizontalScrollIndicator = NO;
    [self addSubview:_scrollView];
    // 计算得每一组的宽度
    CGFloat groWidth = self.polyWidth * _data.dataSets.count + (_data.dataSets.count - 1) * _data.itemSpace + _data.groupSpace;
    CGFloat dViewW = _data.xLabels.count * groWidth + self.chartMargin.left;
    if (dViewW < [UIScreen mainScreen].bounds.size.width) {
        dViewW = [UIScreen mainScreen].bounds.size.width;
    }
    XDDrawView *dView = [[XDDrawView alloc] initWithFrame:CGRectMake(0, 0, dViewW, self.frame.size.height)];
    [dView setPolyWidth:self.polyWidth];
    [dView setGrWidth:groWidth];
    [dView setBrokenLineColor:self.brokenLineColor];
    [dView setBrokenLineTextColor:self.brokenLineTextColor];
    [dView setHistogramColor:self.histogramColor];
    [dView setHistogramTextColor:self.histogramTextColor];
    [dView setChartMargin:self.chartMargin];
    [dView setIsCurve:self.isCurve];
    [dView setLineWidth:self.lineWidth];
    [dView setData:self.data];
    [dView setLineValueArray:self.lineValueArray];
    [_scrollView addSubview:dView];
    _scrollView.contentSize = dView.frame.size;
    
}
// 创建图例
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

- (XDLegendView *)legendView{
    if (!_legendView) {
        self.legendViewScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, 30)];
        self.legendViewScrollView.showsHorizontalScrollIndicator = NO;
        _legendView = [[XDLegendView alloc] init];
        __block CGFloat textWidth = 0;
        [self.legendViewDataArray enumerateObjectsUsingBlock:^(XDLewLegendViewData * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            NSString *legendText = obj.label;
            CGSize size = [legendText sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:10]}];
            
            textWidth = textWidth+size.width + RectWidth + 2*Rect_TextMargin + Rect_TextMargin;
        }];
        NSLog(@"图例整体宽度：%.2f",textWidth);
        CGFloat legendViewX = 0;
        if (textWidth < [UIScreen mainScreen].bounds.size.width) {
            legendViewX = [UIScreen mainScreen].bounds.size.width - textWidth;
        }
        self.legendView.frame = CGRectMake(legendViewX, 0, textWidth, 30);
        self.legendView.textWidth = textWidth;
        [self.legendViewScrollView addSubview:_legendView];
        [self addSubview:self.legendViewScrollView];
        self.legendViewScrollView.contentSize = _legendView.frame.size;
    }
    return _legendView;
}
@end
