//  BubbleLayer.h
//  VideoCoreTest

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

// 一些在注释中使用的叫法
// 箭头: 气泡形状突出那个三角形把它叫做【箭头】
// 箭头的顶点和底点: 将箭头指向的那个点叫为【顶点】，其余两个点叫为【底点】
// 箭头的高度和宽度: 箭头顶点到底点连线的距离叫为【箭头的高度】，两底点的距离叫为【箭头的宽度】
// 矩形框: 气泡形状除了箭头，剩下的部分叫为【矩形框】
// 箭头的相对位置: 如果箭头的方向是向右或者向左，0表达箭头在最上方，1表示箭头在最下方
//              如果箭头的方向是向上或者向下，0表达箭头在最左边，1表示箭头在最右边
//              默认是 0.5，即在中间

// 箭头方向枚举
typedef enum {
    ArrowDirectionRight = 0, //指向右边, 即在圆角矩形的右边
    ArrowDirectionBottom = 1, //指向下边
    ArrowDirectionLeft = 2,  //指向左边
    ArrowDirectionTop = 3,  //指向上边
    
} ArrowDirection;


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


// 这里的size是需要mask成气泡形状的view的size
- (instancetype) initWithSize:(CGSize) originalSize;

- (CAShapeLayer *) layer;  //最终拿这个layer去设置mask

@end

