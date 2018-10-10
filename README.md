##Bubble Layer

###作用 
将一个`view`做成“气泡弹框”的样式，如下图所示：

![](https://ws3.sinaimg.cn/large/006tNbRwgy1fw3lxuse6ej313r0m11kx.jpg)

###使用方法
将`BubbleLayer.h`和`BubbleLayer.m`两个文件导入你的工程，然后在使用的地方`import`头文件。下面是一个使用的例子：

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

[myView.layer setMask:[bubbleLayer layer]];

```


###Demo
不太清楚的参数可以通过使用Demo理解。

![](https://ws1.sinaimg.cn/large/006tNbRwgy1fw3m9v9keuj30ku112qjh.jpg)

