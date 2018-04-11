//
//  XDLegendView.m
//  github地址：https://github.com/liuxiaodongLXD/XDChart
//
//  Created by apple on 2017/12/1.
//  Copyright © 2017年 lxd. All rights reserved.
//

#import "XDLegendView.h"
@implementation XDLegendView

- (instancetype)initWithData:(NSArray<XDLewLegendViewData *> *)data{
    self = [super init];
    if (!self) return nil;
    self.data = data;
    return self;
}

- (instancetype)init{
    self = [super init];
    if (!self) return  nil;
    
    self.backgroundColor = [UIColor clearColor];
    
    return self;
}
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (!self) return  nil;
    
    self.backgroundColor = [UIColor clearColor];
    
    return self;
}
- (void)setData:(NSArray<XDLewLegendViewData *> *)data{
    _data = data;
    switch (_alignment) {
        case LegendAlignmentVertical:{
            break;
        }
        case LegendAlignmentHorizontal:{
            
            CGRect bounds = CGRectMake(0, 0, Margin+(RectWidth+Rect_TextMargin+LegendMargin)*data.count+self.textWidth - data.count * (RectWidth + 2*Rect_TextMargin + Rect_TextMargin) - LegendMargin+Margin, Margin+LegendTextSize+Margin);
            self.bounds = bounds;
            break;
        }
    }
    
}

- (void)drawRect:(CGRect)rect{
    [super drawRect:rect];
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    switch (_alignment) {
        case LegendAlignmentVertical:{
            break;
        }
        case LegendAlignmentHorizontal:{
            __block CGFloat x = Margin;
            // 画矩形方块
            [_data enumerateObjectsUsingBlock:^(XDLewLegendViewData * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                CGContextSetFillColorWithColor(context, obj.color.CGColor);
                CGRect rect = CGRectMake(x, Margin+(LegendTextSize-RectWidth)/2, RectWidth, RectWidth);
                CGContextFillRect(context, rect);
                // 计算文本的尺寸
                CGSize size = [obj.label sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:LegendTextSize]}];
                x += RectWidth + Rect_TextMargin;
                CGRect labelRect = CGRectMake(x, Margin-2, size.width, self.bounds.size.height);
                // 画文本
                [obj.label drawInRect:labelRect withAttributes:@{NSFontAttributeName: [UIFont systemFontOfSize:LegendTextSize], NSForegroundColorAttributeName:[UIColor grayColor]}];
                x += size.width+LegendMargin;
            }];
            break;
        }
    }
}


@end

@implementation XDLewLegendViewData

@end
