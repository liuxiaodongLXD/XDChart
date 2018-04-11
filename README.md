# XDChart
用贝塞尔曲线在一个view上绘制柱状图、折线图，柱状图支持大量数据滚动，支持分组单组，性能极高。
## 效果图
![Image text](https://raw.githubusercontent.com/liuxiaodongLXD/XDChart/master/images/zhengti.gif)
### 柱状图、折线图和上下限
![Image text](https://raw.githubusercontent.com/liuxiaodongLXD/XDChart/master/images/zuifuzaiqingk.gif)
### 单组柱状图
![Image text](https://raw.githubusercontent.com/liuxiaodongLXD/XDChart/master/images/danzhu.gif)
### 多组柱状图
![Image text](https://raw.githubusercontent.com/liuxiaodongLXD/XDChart/master/images/duozhu.gif)
### 折线图
![Image text](https://raw.githubusercontent.com/liuxiaodongLXD/XDChart/master/images/zhe.gif)
### 柱状图和折线图结合
![Image text](https://raw.githubusercontent.com/liuxiaodongLXD/XDChart/master/images/zheandzhu.gif)
### 折线结合上下限
![Image text](https://raw.githubusercontent.com/liuxiaodongLXD/XDChart/master/images/zhuandxian.gif)
## 安装

方法一：利用CocoaPods进行安装

```ruby
pod 'XDChart'
```
方法二：直接把XDChart文件夹拖拽到自己的项目中即可
## 作者
XD, lxd2020nba@163.com，微信号：liudong775
## 使用方法
```
    // 1.创建
    XDDrawChatView *drawChatView = [[XDDrawChatView alloc] init];
    drawChatView.frame = CGRectMake(0, 100, [UIScreen mainScreen].bounds.size.width, 250);
    // 2.设置相关属性
    drawChatView.chartMargin = UIEdgeInsetsMake(15, 0, 25, 0);
    // 2.1 设置柱子的宽度
    drawChatView.polyWidth = 15;
    // 2.2 设置动画时间(不设置默认时间2秒)
    drawChatView.duration = 2.0;
    // 2.3 设置是否需要动画效果
    drawChatView.isNeedAnima = YES;
    
    drawChatView.isCurve = YES;
    // 3.创建每一组的数据模型
    XDDrawDataSet *set = [[XDDrawDataSet alloc] initWithYValues:@[@10,@40,@70,@180,@250,@111,@0] label:@"送检数量"];
    [set setBarColor:[UIColor colorWithRed:245.0 / 255.0 green:94.0 / 255.0 blue:78.0 / 255.0 alpha:1.0f]];
    XDDrawDataSet *set1 = [[XDDrawDataSet alloc] initWithYValues:@[@40,@50,@0,@100,@120,@101,@0] label:@"检验数量"];
    [set1 setBarColor:[UIColor colorWithRed:77.0 / 255.0 green:186.0 / 255.0 blue:122.0 / 255.0 alpha:1.0f]];
    XDDrawDataSet *set2 = [[XDDrawDataSet alloc] initWithYValues:@[@20,@80,@40,@0,@140,@101,@0] label:@"审核数"];
    [set2 setBarColor:[UIColor colorWithRed:17.0 / 255.0 green:16.0 / 255.0 blue:202.0 / 255.0 alpha:1.0f]];
    XDDrawData *data = [[XDDrawData alloc] initWithDataSets:@[set,set1,set2]];
    // 4.赋值数据
    drawChatView.data = data;
    // 5.设置组与组直接的间隔
    data.itemSpace = 0;
    data.groupSpace = 20;
    // 6.X轴数据
    data.xLabels = @[@"一月",@"二月",@"三月",@"四月",@"五月",@"六月",@"七月"];
    // 7.折线数组（为空即不画折线）
    XDDrawDataSet *brokenLineset = [[XDDrawDataSet alloc] initWithYValues:@[@45,@50,@69,@141,@142,@143,@140] label:@""];
    [brokenLineset setBarColor:[UIColor colorWithRed:145.0 / 255.0 green:24.0 / 255.0 blue:78.0 / 255.0 alpha:1.0f]];
    XDDrawData *brokenLinedata = [[XDDrawData alloc] initWithDataSets:@[brokenLineset]];
    brokenLinedata.groupSpace = 80;
    drawChatView.brokenLineData = brokenLinedata;
    // 8.上下限数据
    drawChatView.limitValueArray = [NSMutableArray arrayWithArray:@[@42,@83,@120]];
    NSMutableArray *tuliArray = [[NSMutableArray alloc] init];
    
    XDDrawDataSet *tuliSet = [[XDDrawDataSet alloc] init];
    tuliSet.label = @"上限";
    tuliSet.barColor = [UIColor redColor];
    XDDrawDataSet *tuliSet1 = [[XDDrawDataSet alloc] init];
    tuliSet1.label = @"报警";
    tuliSet1.barColor = [UIColor blueColor];
    XDDrawDataSet *tuliSet2 = [[XDDrawDataSet alloc] init];
    tuliSet2.label = @"下限";
    tuliSet2.barColor = [UIColor greenColor];
    [tuliArray addObject:tuliSet];
    [tuliArray addObject:tuliSet1];
    [tuliArray addObject:tuliSet2];
    drawChatView.limitTuLiValueArray = tuliArray;
    // 9. 折线的宽度
    drawChatView.lineWidth = 2;
    // 10.展示出来
    [drawChatView show];
    [self.view addSubview:drawChatView];
```
