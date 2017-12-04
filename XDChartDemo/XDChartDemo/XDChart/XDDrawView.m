//
//  DrawView.m
//  测试画图demo
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
//@property (nonatomic, strong)CATextLayer *textLayer; //数值文字显示层
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
- (UIColor *)histogramColor{
     if (_histogramColor == nil) {
          _histogramColor = XDHistogramColor;
     }
     return _histogramColor;
}
- (UIColor *)histogramTextColor{
     if (_histogramTextColor == nil) {
          _histogramTextColor = XDHistogramColor;
     }
     return _histogramTextColor;
}
//static CABasicAnimation* fadeAnimation(){
//     CABasicAnimation* fadeAnimation = [CABasicAnimation animationWithKeyPath:@"opacity"];
//     fadeAnimation.fromValue = [NSNumber numberWithFloat:0.0];
//     fadeAnimation.toValue = [NSNumber numberWithFloat:1.0];
//     fadeAnimation.duration = 5.0;
//     return fadeAnimation;
//}
- (void)drawRect:(CGRect)rect {
     [super drawRect:rect];
     

     
     
     NSLog(@"宽度:%f",self.bounds.size.width);
     
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
     
     // 画x轴上的坐标
     NSMutableParagraphStyle *paragraph2=[[NSMutableParagraphStyle alloc] init];
     paragraph2.alignment = NSTextAlignmentCenter; // 居中
     NSMutableDictionary *attrDict2 = [NSMutableDictionary dictionary];
     attrDict2[NSFontAttributeName] = [UIFont systemFontOfSize:9];
     attrDict2[NSParagraphStyleAttributeName] = paragraph2;
     attrDict2[NSForegroundColorAttributeName] = [UIColor blackColor];
     [self.data.xLabels enumerateObjectsUsingBlock:^(NSString *  _Nonnull obj, NSUInteger i, BOOL * _Nonnull stop) {
          // 画x轴的值
          CGFloat w = self.grWidth;
          CGFloat x = i * w + self.chartMargin.left;
          CGRect titleRect = CGRectMake(x,self.frame.size.height - 20,w,20);
          NSLog(@"x值：%f , 宽度：%f",x,w);
          [obj drawInRect:titleRect withAttributes:attrDict2];
     }];
     // 如果柱状图数组为空并且折线图数组有值就只画折线图
//     if (self.histogramValueArray.count == 0 && self.yValue.count) {
//          [self drawLineChart];
//          return;
//     }
     float max = 0;
     NSMutableArray *maxArray = [NSMutableArray array];
     for (int i = 0; i<_data.dataSets.count; i++) {
          XDDrawDataSet *dataset = _data.dataSets[i];
          float max1 = [[dataset.yValues valueForKeyPath:@"@max.floatValue"] floatValue];
          [maxArray addObject:@(max1)];
          max = [[maxArray valueForKeyPath:@"@max.floatValue"] floatValue];
          for (int j = 0; j<dataset.yValues.count; j++) {
               CGFloat w = self.grWidth;
               CGFloat x = self.chartMargin.left + j*w + i*(self.polyWidth + _data.itemSpace) + _data.groupSpace * 0.5;
               CGFloat y = self.frame.size.height - (((self.frame.size.height - self.chartMargin.bottom - self.chartMargin.top) * [dataset.yValues[j] floatValue]) / max) - self.chartMargin.bottom;
               NSLog(@"柱子的x = %f , 下标： %d， Y = %f",x,i,y);
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
               NSLog(@"柱子上文字的宽度：%.2f",size.width);
               CGRect titleRect = CGRectMake(x,y - 10,size.width,20);
               [[dataset.yValues[j] stringValue] drawInRect:titleRect withAttributes:attrDict];
//               if (_textLayer) {
//                    _textLayer.position = CGPointMake(x , y);
//                    [self setBarText:[dataset.yValues[j] stringValue]];
//                    CABasicAnimation *fade = fadeAnimation();
//                    [self.textLayer addAnimation:fade forKey:nil];
//               }
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
               
               //开始添加动画
               [CATransaction begin];
               //创建一个strokeEnd路径的动画
               CABasicAnimation *pathAnimation2 = [CABasicAnimation animationWithKeyPath:@"opacity"];
               //动画时间
               pathAnimation2.duration = 4.5;
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
     if (self.lineValueArray.count) {
          [self drawLineChart:self.lineValueArray max:max];
     }
     }
     

/**
 画折线图
 */
- (void)drawLineChart:(NSArray*)yValue max:(CGFloat)max{
     UIBezierPath *bezierPath = [UIBezierPath bezierPath];
     // 画第一个点
     CGFloat x0 = 0;
     CGFloat y0 = 0;
//     float max = [[yValue valueForKeyPath:@"@max.floatValue"] floatValue];
     [bezierPath moveToPoint:CGPointMake(self.chartMargin.left + self.grWidth * 0.5, self.frame.size.height - ((self.frame.size.height - self.chartMargin.bottom - self.chartMargin.top) * [yValue[0] floatValue]) / max - self.chartMargin.bottom)];
     // 画折线上的点设置的属性
     NSMutableParagraphStyle *brokenLinePointParagraph=[[NSMutableParagraphStyle alloc]init];
     brokenLinePointParagraph.alignment = NSTextAlignmentCenter; // 居中
     NSMutableDictionary *brokenLinePointAttrDict = [NSMutableDictionary dictionary];
     brokenLinePointAttrDict[NSFontAttributeName] = [UIFont systemFontOfSize:9];
     brokenLinePointAttrDict[NSParagraphStyleAttributeName] = brokenLinePointParagraph;
     brokenLinePointAttrDict[NSForegroundColorAttributeName] = self.brokenLineTextColor;
     for (NSInteger i = 0; i < yValue.count; i++) {
          CGFloat x = (i+1) * self.grWidth + self.chartMargin.left - self.grWidth * 0.5;
          CGFloat y = self.frame.size.height - (((self.frame.size.height - self.chartMargin.bottom - self.chartMargin.top) * [yValue[i] floatValue]) / max) - self.chartMargin.bottom;
          // 折线上的数字尺寸
          CGSize size = [[yValue[i] stringValue] sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:9]}];
          CGRect titleRect = CGRectMake(x- size.width * 0.5,y - 15,size.width,20);
          [[yValue[i] stringValue] drawInRect:titleRect withAttributes:brokenLinePointAttrDict];
          // 画拐折点
          UIBezierPath *yuanPath = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(x-2, y-2, 4, 4) cornerRadius:4];
          CAShapeLayer *layer = [CAShapeLayer layer];
          layer.strokeColor = [UIColor purpleColor].CGColor;
          layer.fillColor = [UIColor clearColor].CGColor;
          layer.path = yuanPath.CGPath;
          [self.layer addSublayer:layer];
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
     shapelayer.strokeColor = self.brokenLineColor.CGColor;
     shapelayer.lineWidth = self.lineWidth;
     shapelayer.fillColor = [[UIColor clearColor]CGColor];
     shapelayer.path = bezierPath.CGPath;
     [self.layer addSublayer:shapelayer];
     // 添加动画
     CABasicAnimation *pathAnimation = [CABasicAnimation animationWithKeyPath:@"opacity"];
     pathAnimation.duration = 4.5;
     pathAnimation.fromValue = @0;
     pathAnimation.toValue = @1;
     pathAnimation.autoreverses = NO;
     [shapelayer addAnimation:pathAnimation forKey:@"strokeEndAnimation"];

}


//- (CATextLayer *)textLayer{
//     if (!_textLayer) {
//          _textLayer = [CATextLayer layer];
//          _textLayer.foregroundColor = [UIColor blackColor].CGColor;
//          _textLayer.fontSize = 12;
//          _textLayer.alignmentMode = kCAAlignmentCenter;
//          _textLayer.contentsScale = [[UIScreen mainScreen] scale];
//          CGRect bounds = CGRectMake(0, 0, 20, 10);
//          bounds.size.height = 10;
//          bounds.size.width *= 2;
//          _textLayer.bounds = bounds;
//
//          [self.layer addSublayer:_textLayer];
//     }
//     return _textLayer;
//}
//
////设置数值
//- (void)setBarText:(NSString*)text{
//     self.textLayer.string = text;
//}














//     for (NSInteger i = 0; i < self.histogramValueArray.count; i++) {
//          float max = [[self.histogramValueArray valueForKeyPath:@"@max.floatValue"] floatValue];
//          CGFloat x = i * self.groupWidth + self.chartMargin.left;
//          CGFloat y = self.frame.size.height - (((self.frame.size.height - self.chartMargin.bottom - self.chartMargin.top) * [self.histogramValueArray[i] floatValue]) / max) - self.chartMargin.bottom;
//          NSLog(@"柱子的y = %f",y);
//          // 画柱子上的字
//          NSMutableParagraphStyle *paragraph=[[NSMutableParagraphStyle alloc]init];
//          paragraph.alignment=NSTextAlignmentCenter; // 居中
//          NSMutableDictionary *attrDict = [NSMutableDictionary dictionary];
//          attrDict[NSFontAttributeName] = [UIFont systemFontOfSize:9];
//          attrDict[NSParagraphStyleAttributeName] = paragraph;
//          attrDict[NSForegroundColorAttributeName] = self.histogramTextColor;
//          // 画柱子上的字
//          CGRect titleRect = CGRectMake(x - self.groupWidth * 0.5,y - 10,self.groupWidth,20);
//          [[self.histogramValueArray[i] stringValue] drawInRect:titleRect withAttributes:attrDict];
//
//          // 画柱状图
//          UIBezierPath *Polyline = [UIBezierPath bezierPath];
//          //设置起点
//          [Polyline moveToPoint:CGPointMake(x, self.frame.size.height - self.chartMargin.bottom)];
//          //设置终点
//          [Polyline addLineToPoint:CGPointMake(x,y)];
//
//          //添加CAShapeLayer
//          CAShapeLayer *shapeLine = [[CAShapeLayer alloc] init];
//          //设置颜色
//          shapeLine.strokeColor = self.histogramColor.CGColor;
//          //设置宽度
//          shapeLine.lineWidth = self.polyWidth;
//          //把CAShapeLayer添加到当前视图CAShapeLayer
//          [self.layer addSublayer:shapeLine];
//          //把Polyline的路径赋予shapeLine
//          shapeLine.path = Polyline.CGPath;
//
//          //开始添加动画
//          [CATransaction begin];
//          //创建一个strokeEnd路径的动画
//          CABasicAnimation *pathAnimation2 = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
//          //动画时间
//          pathAnimation2.duration = 5.0;
//          //添加动画样式
//          pathAnimation2.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
//          //动画起点
//          pathAnimation2.fromValue = @0.0f;
//          //动画停止位置
//          pathAnimation2.toValue   = @1.0f;
//          //把动画添加到CAShapeLayer
//          [shapeLine addAnimation:pathAnimation2 forKey:@"strokeEndAnimation"];
//          //动画终点
//          shapeLine.strokeEnd = 1.0;
//          //结束动画
//          [CATransaction commit];
//     }

     // 画折线图
//     if (self.yValue.count) {
//          [self drawLineChart];
//     }
//}

@end
