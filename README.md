## Bubble Layer

根据`View`的`size`生成一个气泡式的`CAShapeLayer`，然后去`mask`这个`View`。

三角形箭头的宽度、高度、方向和左右(上下)位置以及矩形的圆角半径等属性都是可以自定义的。

使用示例:

```objc
BubbleLayer *bubbleLayer = [[BubbleLayer alloc]initWithSize:myView.bounds.size];

bubbleLayer.arrowDirection = ArrowDirectionLeft;
bubbleLayer.arrowHeight = 22;
bubbleLayer.arrowWidth = 30;
bubbleLayer.arrowPosition = 0.8;
bubbleLayer.cornerRadius = 20;

[myView.layer setMask:[bubbleLayer layer]];

```
各种示例效果：

<img src="http://7xtkyf.com2.z0.glb.clouddn.com/2017-04-26_BubbleView_5.png" width="400"/>


#### 实现原理

[详情](http://ihandle.top/2017/04/26/2017-04-26_BubbleView/)