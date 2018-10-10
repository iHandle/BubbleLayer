//  BubbleLayer.h
//  VideoCoreTest
//  Copyright © 2017年 SCNU. All rights reserved.
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

// 一些在注释中使用的叫法
// 箭头: 气泡弹框突出那个三角形把它叫做【箭头】
// 箭头的顶点和底点: 将箭头指向的那个点叫为【顶点】，其余两个点叫为【底点】
// 箭头的高度和宽度: 箭头顶点到底点连线的距离叫为【箭头的高度】，两底点的距离叫为【箭头的宽度】
// 矩形框: 气泡弹框除了箭头，剩下的部分叫为【矩形框】
// 箭头的相对位置: 如果箭头的方向是向右或者向左，0表达箭头在最上方，1表示箭头在最下方
//              如果箭头的方向是向上或者向下，0表达箭头在最左边，1表示箭头在最右边

// 箭头方向枚举
typedef enum {
    ArrowDirectionRight = 0, //指向右边, 即在圆角矩形的右边
    ArrowDirectionBottom,
    ArrowDirectionLeft,
    ArrowDirectionTop,
    
} ArrowDirection;

// 默认的参数
#define CORNER_RADIUS 8     // 默认矩形框圆角半径
#define ARROW_WIDTH 30      // 默认箭头宽带
#define ARROW_HEIGHT 12     // 默认箭头高度
#define ARROW_DIRECTION 1   // 默认箭头方向，向下
#define ARROW_POSITION 0.5  // 默认箭头相对位置，居中
#define ARROW_RADIUS 3      // 默认箭头指向处的圆角半径



@interface BubbleLayer : NSObject

// 矩形的圆角的半径
@property CGFloat cornerRadius;
// 箭头位置的圆角半径
@property CGFloat arrowRadius;
// 箭头的高度
@property CGFloat arrowHeight;
// 箭头的宽度
@property CGFloat arrowWidth;
// 箭头方向
@property ArrowDirection arrowDirection;
// 箭头的相对位置
@property CGFloat arrowPosition;

// 这里的size是需要mask成气泡弹框的view的size
- (instancetype) initWithSize:(CGSize) size;

- (CAShapeLayer *) layer;  //最终拿这个layer去设置mask
@end

