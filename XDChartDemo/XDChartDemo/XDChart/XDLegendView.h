//
//  XDLegendView.h
//  测试画图demo
//
//  Created by apple on 2017/12/1.
//  Copyright © 2017年 lxd. All rights reserved.
//

#import <UIKit/UIKit.h>
#define LegendTextSize 10
#define RectWidth 7
#define Rect_TextMargin 5
#define LegendMargin 7
#define Margin 5

typedef NS_ENUM(NSInteger, LegendAlignment) {
    LegendAlignmentHorizontal = 0,
    LegendAlignmentVertical,
};
@class XDLewLegendViewData;
@interface XDLegendView : UIView
@property (nonatomic, assign) LegendAlignment alignment;
// 图例整体的宽度
@property (nonatomic, assign) CGFloat textWidth;
@property (nonatomic, strong) NSArray<XDLewLegendViewData *> *data;

- (instancetype)initWithData:(NSArray<XDLewLegendViewData *> *)data;
@end

@interface XDLewLegendViewData : NSObject
// 图例文字
@property (nonatomic, strong) NSString *label;
// 图例上方块的颜色
@property (nonatomic, strong) UIColor *color;
@end
