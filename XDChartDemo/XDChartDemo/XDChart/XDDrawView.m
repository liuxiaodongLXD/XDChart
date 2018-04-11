//
//  DrawView.m
//  github地址：https://github.com/liuxiaodongLXD/XDChart
//
//  Created by apple on 2017/11/23.
//  Copyright © 2017年 lxd. All rights reserved.
//
// 柱子的颜色
#define XDHistogramColor [UIColor colorWithRed:0.400 green:1.000 blue:1.000 alpha:0.8]
// 折线的颜色
#define XDLineDrawColor [UIColor colorWithRed:22/255.0 green:217/255.0 blue:132/255.0 alpha:1.0]

#import "XDDrawView.h"
#import "XDDrawData.h"

@interface XDDrawView()
/** X轴的值 */
@property (nonatomic, strong) NSArray *textArray;
/**  */
@property (nonatomic, strong) NSArray *yValue;
/** <##> */
@property (nonatomic, strong) NSArray *histogramValueArray;
/** <##> */
@property (nonatomic, assign) CGFloat maxValue;
/** <##> */
@property (nonatomic, assign) CGFloat minValue;

@end
@implementation XDDrawView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}
- (CGFloat)lineWidth{
    if (_lineWidth < 1) {
        _lineWidth = 1;
    }
    return _lineWidth;
}
- (UIColor *)brokenLineTextColor{
    if (_brokenLineTextColor == nil) {
        _brokenLineTextColor = XDLineDrawColor;
    }
    return _brokenLineTextColor;
}
- (UIColor *)brokenLineColor{
    if (_brokenLineColor == nil) {
        _brokenLineColor = XDLineDrawColor;
    }
    return _brokenLineColor;
}
- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    
    // ---------------------画X轴开始---------------------
    //获得上下文
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    //画直线，设置路径颜色
    CGContextSetStrokeColorWithColor(ctx, [UIColor blackColor].CGColor);
    //设置线宽度
    CGContextSetLineWidth(ctx, 1);
    //起始点
    CGContextMoveToPoint(ctx, 0, self.bounds.size.height - self.chartMargin.bottom);
    //从起始点连线到另一个点
    CGContextAddLineToPoint(ctx, self.bounds.size.width, self.bounds.size.height - self.chartMargin.bottom);
    //画线
    CGContextStrokePath(ctx);
    // ---------------------画X轴结束---------------------
    
    
    
    // 画x轴上的坐标文字
    NSMutableParagraphStyle *paragraph2=[[NSMutableParagraphStyle alloc] init];
    paragraph2.alignment = NSTextAlignmentCenter; // 居中
    NSMutableDictionary *attrDict2 = [NSMutableDictionary dictionary];
    attrDict2[NSFontAttributeName] = [UIFont systemFontOfSize:9];
    attrDict2[NSParagraphStyleAttributeName] = paragraph2;
    attrDict2[NSForegroundColorAttributeName] = [UIColor blackColor];
    // 柱状图数据不为空
    if (self.data != nil) {
        [self.data.xLabels enumerateObjectsUsingBlock:^(NSString *  _Nonnull obj, NSUInteger i, BOOL * _Nonnull stop) {
            // 画x轴的值
            CGFloat w = self.grWidth;
            CGFloat x = i * w + self.chartMargin.left;
            CGRect titleRect = CGRectMake(x,self.frame.size.height - 20,w,20);
            [obj drawInRect:titleRect withAttributes:attrDict2];
        }];
    }else if (self.brokenLineData != nil){
        [self.brokenLineData.xLabels enumerateObjectsUsingBlock:^(NSString *  _Nonnull obj, NSUInteger i, BOOL * _Nonnull stop) {
            // 画x轴的值
            CGFloat w = self.grWidth;
            CGFloat x = i * w + self.chartMargin.left;
            CGRect titleRect = CGRectMake(x,self.frame.size.height - 20,w,20);
            [obj drawInRect:titleRect withAttributes:attrDict2];
        }];
    }
    // 求所有数据中的最大值（包括每一组柱状图、每一组折线图、需要画的上下限）
    float max = 0;
    float min = 0;
    NSMutableArray *maxArray = [NSMutableArray array];
    NSMutableArray *minArray = [NSMutableArray array];
    NSArray<XDDrawDataSet *> *brokenLineArray = self.brokenLineData.dataSets;
    for (int i = 0; i < brokenLineArray.count; i++) {
        XDDrawDataSet *dataSet = brokenLineArray[i];
        float max0 = [[dataSet.yValues valueForKeyPath:@"@max.floatValue"] floatValue];
        float min0 = [[dataSet.yValues valueForKeyPath:@"@min.floatValue"] floatValue];
        [maxArray addObject:@(max0)];
        [minArray addObject:@(min0)];
    }
    float max10 = [[self.limitValueArray valueForKeyPath:@"@max.floatValue"] floatValue];
    float min10 = [[self.limitValueArray valueForKeyPath:@"@min.floatValue"] floatValue];
    [maxArray addObject:@(max10)];
    [minArray addObject:@(min10)];
    if (_data != nil) {
        for (int i = 0; i<_data.dataSets.count; i++) {
            XDDrawDataSet *dataset = _data.dataSets[i];
            float max1 = [[dataset.yValues valueForKeyPath:@"@max.floatValue"] floatValue];
            float min1 = [[dataset.yValues valueForKeyPath:@"@min.floatValue"] floatValue];
            [maxArray addObject:@(max1)];
            [minArray addObject:@(min1)];
            max = [[maxArray valueForKeyPath:@"@max.floatValue"] floatValue];
            min = [[minArray valueForKeyPath:@"@min.floatValue"] floatValue];
            self.maxValue = max;
            self.minValue = min;
            // 画柱状图
            if (self.isDrawColumnar) {
                for (int j = 0; j<dataset.yValues.count; j++) {
                    CGFloat w = self.grWidth;
                    CGFloat x = self.chartMargin.left + j*w + i*(self.polyWidth + _data.itemSpace) + _data.groupSpace * 0.5;
                    CGFloat y = self.frame.size.height - (((self.frame.size.height - self.chartMargin.bottom - self.chartMargin.top) * [dataset.yValues[j] floatValue]) / max) - self.chartMargin.bottom;
//                    NSLog(@"柱子的x = %f , 下标： %d， Y = %f",x,i,y);
                    // 画柱子上的字
                    NSMutableParagraphStyle *paragraph = [[NSMutableParagraphStyle alloc] init];
                    paragraph.alignment = NSTextAlignmentCenter; // 居中
                    NSMutableDictionary *attrDict = [NSMutableDictionary dictionary];
                    attrDict[NSFontAttributeName] = [UIFont systemFontOfSize:9];
                    attrDict[NSParagraphStyleAttributeName] = paragraph;
                    attrDict[NSForegroundColorAttributeName] = dataset.barColor;
                    // 画柱子上的字
                    CGSize size = [[dataset.yValues[j] stringValue] sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:9]}];
                    size.width = size.width < self.polyWidth ? self.polyWidth : size.width;
//                    NSLog(@"柱子上文字的宽度：%.2f",size.width);
                    CGRect titleRect = CGRectMake(x,y - 10,size.width,20);
                    [[dataset.yValues[j] stringValue] drawInRect:titleRect withAttributes:attrDict];
                    // 画柱状图
                    UIBezierPath *Polyline = [UIBezierPath bezierPath];
                    //设置起点
                    [Polyline moveToPoint:CGPointMake(x + self.polyWidth * 0.5, self.frame.size.height - self.chartMargin.bottom)];
                    //设置终点
                    [Polyline addLineToPoint:CGPointMake(x + self.polyWidth * 0.5,y)];
                    
                    //添加CAShapeLayer
                    CAShapeLayer *shapeLine = [[CAShapeLayer alloc] init];
                    //设置颜色
                    shapeLine.strokeColor = dataset.barColor.CGColor;
                    //设置宽度
                    shapeLine.lineWidth = self.polyWidth;
                    //把CAShapeLayer添加到当前视图CAShapeLayer
                    [self.layer addSublayer:shapeLine];
                    //把Polyline的路径赋予shapeLine
                    shapeLine.path = Polyline.CGPath;
                    // 是否要加动画效果
                    if (self.isNeedAnima) {
                        //开始添加动画
                        [CATransaction begin];
                        //创建一个strokeEnd路径的动画  opacity
                        CABasicAnimation *pathAnimation2 = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
                        //动画时间
                        pathAnimation2.duration = self.duration;
                        //添加动画样式
                        pathAnimation2.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
                        //动画起点
                        pathAnimation2.fromValue = @0.0f;
                        //动画停止位置
                        pathAnimation2.toValue = @1.0f;
                        //把动画添加到CAShapeLayer
                        [shapeLine addAnimation:pathAnimation2 forKey:@"strokeEndAnimation"];
                        //动画终点
                        shapeLine.strokeEnd = 1.0;
                        //结束动画
                        [CATransaction commit];
                    }
                }
                
            }
        }
    }else if (self.brokenLineData != nil){
        for (int i = 0; i<_brokenLineData.dataSets.count; i++) {
            XDDrawDataSet *dataset = _brokenLineData.dataSets[i];
            float max1 = [[dataset.yValues valueForKeyPath:@"@max.floatValue"] floatValue];
            float min1 = [[dataset.yValues valueForKeyPath:@"@min.floatValue"] floatValue];
            [maxArray addObject:@(max1)];
            [minArray addObject:@(min1)];
            max = [[maxArray valueForKeyPath:@"@max.floatValue"] floatValue];
            min = [[minArray valueForKeyPath:@"@min.floatValue"] floatValue];
            self.maxValue = max;
            self.minValue = min;
        }
    }
    
    // 画折线(多条)
    if (self.brokenLineData != nil) {
        [self drawLineChart2:self.brokenLineData max:max min:39];
    }
    // 如果上下限数组有值就画上下线
    if (self.limitValueArray.count) {
        [self drawlimitLineChart:self.limitValueArray max:max];
    }
}

/**
 画上下线
 
 @param limitValue 值数组
 @param max 最大值
 */
- (void)drawlimitLineChart:(NSArray *)limitValue max:(CGFloat)max{
    for (int i = 0; i < limitValue.count; i++) {
        CGFloat y1 = [self getValueHeight:[limitValue[i] floatValue]];
        UIBezierPath *path = [UIBezierPath bezierPath];
        [path moveToPoint:CGPointMake(0 , y1)];
        [path addLineToPoint:CGPointMake(self.bounds.size.width, y1)];
        CAShapeLayer *shapelayer = [CAShapeLayer layer];
        XDDrawDataSet *ds = self.limitTuLiValueArray[i];
        
        shapelayer.strokeColor = [ds.barColor CGColor];//self.colorsArray[i].CGColor;
        shapelayer.lineWidth = 1; // self.lineWidth;
        shapelayer.fillColor = [[UIColor clearColor] CGColor];
        shapelayer.path = path.CGPath;
        [self.layer addSublayer:shapelayer];
        // 添加动画
        if (self.isNeedAnima) {
            CABasicAnimation *pathAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
            pathAnimation.duration = self.duration;
            pathAnimation.fromValue = @0;
            pathAnimation.toValue = @1;
            pathAnimation.autoreverses = NO;
            [shapelayer addAnimation:pathAnimation forKey:@"strokeEndAnimation"];
        }
    }
}


/**
 画折线图（支持多条）

 @param brokenData 每一条折线图的所有数据
 @param max 最大值
 */
- (void)drawLineChart2:(XDDrawData*)brokenData max:(CGFloat)max min:(CGFloat)min{
    // allYValues中存储的每一组折线图的点数组
    NSMutableArray *allYValues = [[NSMutableArray alloc] init];
    for (int i = 0; i < brokenData.dataSets.count; i++) {
        XDDrawDataSet *set = brokenData.dataSets[i];
        [allYValues addObject:set.yValues];
    }
    CGFloat ndgLineInterval = 0;
    if (self.isNdg) { // 正态分布图
        ndgLineInterval = self.ndgLineWidth;
    }else{
        ndgLineInterval = self.grWidth;
    }
    for (int j = 0; j < allYValues.count; j++) {
        // 取出数据
        XDDrawDataSet *dSet = brokenData.dataSets[j];
        NSArray *yValue = allYValues[j];
        UIBezierPath *bezierPath = [UIBezierPath bezierPath];
        // 画第一个点
        CGFloat x0 = 0;
        CGFloat y0 = 0;
        CGFloat yy = [self getValueHeight:[yValue[0] floatValue]];
        [bezierPath moveToPoint:CGPointMake(self.chartMargin.left + ndgLineInterval * 0.5, yy)];
        // 画折线上的点设置的属性
        NSMutableParagraphStyle *brokenLinePointParagraph=[[NSMutableParagraphStyle alloc]init];
        brokenLinePointParagraph.alignment = NSTextAlignmentCenter; // 居中
        NSMutableDictionary *brokenLinePointAttrDict = [NSMutableDictionary dictionary];
        brokenLinePointAttrDict[NSFontAttributeName] = [UIFont systemFontOfSize:9];
        brokenLinePointAttrDict[NSParagraphStyleAttributeName] = brokenLinePointParagraph;
        brokenLinePointAttrDict[NSForegroundColorAttributeName] = dSet.barColor;
        for (NSInteger i = 0; i < yValue.count; i++) {
            CGFloat x = (i+1) * ndgLineInterval + self.chartMargin.left - ndgLineInterval * 0.5;
            CGFloat y = [self getValueHeight:[yValue[i] floatValue]];
            // 折线上的数字尺寸
            CGSize size = [[yValue[i] stringValue] sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:9]}];
            CGRect titleRect = CGRectMake(x- size.width * 0.5,y - 15,size.width,20);
            if (!self.isNdg) {
                [[yValue[i] stringValue] drawInRect:titleRect withAttributes:brokenLinePointAttrDict];
                // 画拐折点
                UIBezierPath *yuanPath = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(x-2, y-2, 4, 4) cornerRadius:4];
                CAShapeLayer *layer = [CAShapeLayer layer];
                layer.strokeColor = dSet.barColor.CGColor;
                layer.fillColor = [UIColor clearColor].CGColor;
                layer.path = yuanPath.CGPath;
                [self.layer addSublayer:layer];
            }
            if (i > 0) {
                // 连线
                // 折线
                if (self.isCurve) {
                    // 曲线
                    [bezierPath addCurveToPoint:CGPointMake(x, y) controlPoint1:CGPointMake((x0 + x)/2, y0) controlPoint2:CGPointMake((x0 + x)/2, y)];
                }else{
                    [bezierPath addLineToPoint:CGPointMake(x, y)];
                }
            }
            x0 = x;
            y0 = y;
        }
        CAShapeLayer *shapelayer = [CAShapeLayer layer];
        shapelayer.strokeColor = dSet.barColor.CGColor;
        shapelayer.lineWidth = self.lineWidth;
        shapelayer.fillColor = [[UIColor clearColor] CGColor];
        shapelayer.path = bezierPath.CGPath;
        [self.layer addSublayer:shapelayer];
        
        // 添加动画
        if (self.isNeedAnima) {
            CABasicAnimation *pathAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
            pathAnimation.duration = self.duration;
            pathAnimation.fromValue = @0;
            pathAnimation.toValue = @1;
            pathAnimation.autoreverses = NO;
            [shapelayer addAnimation:pathAnimation forKey:@"strokeEndAnimation"];
        }
        
    }
}

/**
 获取value所占view的高度(针对折线图)

 @param value 每一个值
 @return 高度
 */
- (CGFloat)getValueHeight:(CGFloat)value{
    CGFloat valuePercent = (ABS(value - self.minValue) / ABS((self.maxValue - self.minValue)));
    CGFloat y = (self.frame.size.height - (self.chartMargin.bottom + self.chartMargin.top)) * (1 - valuePercent) + self.chartMargin.top;
    return y;
}
@end
