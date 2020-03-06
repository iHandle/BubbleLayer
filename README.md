### Bubble Layer

用于将一个`view`做成“气泡”的样式，效果如下图所示：

<img src="https://i.imgur.com/ahemgD8.png" width="300"/>

#### 使用方法
将`BubbleLayer.h`和`BubbleLayer.m`两个文件导入你的工程，然后在使用的地方`import`头文件。如果是`Swift`工程，可以直接导入`BubbleLayer.swift`。

下面是一个使用`Objective-C`的例子：

```objc
BubbleLayer *bbLayer = [[BubbleLayer alloc]initWithSize:myView.bounds.size];

// 矩形框的圆角半径
bbLayer.cornerRadius = 20;

// 凸起那部分暂且称之为“箭头”，下面的参数设置它的形状
bbLayer.arrowDirection = ArrowDirectionLeft;
bbLayer.arrowHeight = 22;   // 箭头的高度（长度）
bbLayer.arrowWidth = 30;    // 箭头的宽度
bbLayer.arrowPosition = 0.5;// 箭头的相对位置
bbLayer.arrowRadius = 3;    // 箭头处的圆角半径

[myView.layer setMask:[bbLayer layer]];

```

#### Demo
如果不太清楚的参数的含义，可以通过使用Demo理解。

<img src="https://i.imgur.com/leO6enP.gif" width="300"/>



