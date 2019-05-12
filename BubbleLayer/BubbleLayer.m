//  BubbleLayer.m
//  VideoCoreTest
//
#import "BubbleLayer.h"


@interface BubbleLayer()


// 需要mask成气泡弹框的view的size
@property (nonatomic) CGSize size;


@end

@implementation BubbleLayer


#pragma mark - preparation

// 关键点:箭头的三个点和矩形的四个角的点
-(NSMutableArray *)keyPoints {
    
    NSMutableArray *points = [[NSMutableArray alloc]init];
    
    // 先确定箭头的三个点
    CGPoint beginPoint;  // 按顺时针画箭头时的第一个支点，例如箭头向上时的左边的支点
    CGPoint topPoint; // 顶点
    CGPoint endPoint;  // 另外一个支点
    
    // 箭头顶点topPoint的X坐标(或Y坐标)的范围（用来计算arrowPosition）
    CGFloat tpXRange = _size.width - 2 * _cornerRadius - _arrowWidth;
    CGFloat tpYRange = _size.height - 2 * _cornerRadius - _arrowWidth;
    
    // 这几个参数用于确定矩形框的位置(就是给箭头腾出空间后剩下的区域)
    // 这些参数在下面会根据箭头的位置进行调整
    CGFloat x = 0, y = 0;  // 矩形框左上角的坐标
    CGFloat width = _size.width, height = _size.height; //矩形框的大小
    
    // 计算箭头的位置，以及调整矩形框的位置和大小
    switch (_arrowDirection) {
            
            //箭头在右
        case ArrowDirectionRight:
            
            topPoint = CGPointMake(_size.width , _size.height / 2 + tpYRange*(_arrowPosition - 0.5));
            beginPoint = CGPointMake(topPoint.x - _arrowHeight, topPoint.y - _arrowWidth/2);
            endPoint = CGPointMake(beginPoint.x, beginPoint.y + _arrowWidth);
            
            width -= _arrowHeight; //矩形框右边的位置“腾出”给箭头
            break;
            
            //箭头在下
        case ArrowDirectionBottom:
            topPoint = CGPointMake(_size.width / 2 + tpXRange*(_arrowPosition - 0.5), _size.height);
            beginPoint = CGPointMake(topPoint.x + _arrowWidth/2, topPoint.y - _arrowHeight);
            endPoint = CGPointMake(beginPoint.x - _arrowWidth, beginPoint.y);
            
            height -= _arrowHeight;
            break;
            
            //箭头在左
        case ArrowDirectionLeft:
           topPoint = CGPointMake(0, _size.height / 2 + tpYRange*(_arrowPosition - 0.5));
            beginPoint = CGPointMake(topPoint.x + _arrowHeight, topPoint.y + _arrowWidth/2);
            endPoint = CGPointMake(beginPoint.x, beginPoint.y - _arrowWidth);
            
            x = _arrowHeight;
            width -= _arrowHeight;
            break;
            
            //箭头在上
        case ArrowDirectionTop:
            topPoint = CGPointMake(_size.width / 2 + tpXRange*(_arrowPosition - 0.5), 0);
            beginPoint = CGPointMake(topPoint.x - _arrowWidth/2, topPoint.y + _arrowHeight);
            endPoint = CGPointMake(beginPoint.x + _arrowWidth, beginPoint.y);
            
            y = _arrowHeight;
            height -= _arrowHeight;
            break;
    }
    
    // 先把箭头的三个点放进关键点数组中
    points = [NSMutableArray arrayWithObjects:[NSValue valueWithCGPoint:beginPoint],
                  [NSValue valueWithCGPoint:topPoint],
                  [NSValue valueWithCGPoint:endPoint],  nil];
    
    
    
    //确定圆角矩形的四个点
    CGPoint bottomRight = CGPointMake(x+width, y+height); //右下角的点
    CGPoint bottomLeft = CGPointMake(x, y+height);
    CGPoint topLeft = CGPointMake(x, y);
    CGPoint topRight = CGPointMake(x+width, y);
    
    
    //先放在一个临时数组, 放置顺序跟下面紧接着的操作有关
    NSMutableArray *rectPoints = [NSMutableArray arrayWithObjects: [NSValue valueWithCGPoint:bottomRight],
                                  [NSValue valueWithCGPoint:bottomLeft],
                                  [NSValue valueWithCGPoint:topLeft],
                                  [NSValue valueWithCGPoint:topRight],  nil];
    
    
    // 绘制气泡弹框的时候，从箭头开始,顺时针地进行
    // 箭头向右时，画完箭头之后会先画到矩形框的右下角
    // 所以此时先把矩形框右下角的点放进关键点数组,其他三个点按顺时针方向添加
    // 箭头在其他方向时，以此类推
    int rectPointIndex = (int)_arrowDirection;
    for(int i=0; i<4; i++) {
        [points addObject:[rectPoints objectAtIndex:rectPointIndex]];
        rectPointIndex = (rectPointIndex+1)%4;
    }
    
         
    return points;
}


#pragma mark - draw

// 绘制气泡形状,获取path
- (CGPathRef )bubblePath {
    
    UIGraphicsBeginImageContextWithOptions(self.size, NO, 0.0);
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    // 获取绘图所需要的关键点
    NSMutableArray *points = [self keyPoints];
    
    // 第一步是要画箭头的“第一个支点”所在的那个角，所以要把“笔”放在这个支点顺时针顺序的上一个点
    // 所以把“笔”放在最后才画的矩形框的角的位置, 准备开始画箭头
    CGPoint currentPoint = [[points objectAtIndex:6] CGPointValue];
    CGContextMoveToPoint(ctx, currentPoint.x, currentPoint.y);
    
    CGPoint pointA, pointB;  //用于 CGContextAddArcToPoint函数
    CGFloat radius;
    int count = 0;
    
    while(count < 7) {
        // 整个过程需要画七个圆角，所以分为七个步骤
        
        // 箭头处的三个圆角和矩形框的四个圆角不一样
        radius = count < 3 ?  _arrowRadius : _cornerRadius;
        
        pointA = [[points objectAtIndex:count] CGPointValue];
        pointB = [[points objectAtIndex:(count+1)%7] CGPointValue];
        // 画矩形框最后一个角的时候，pointB就是points[0]

        CGContextAddArcToPoint(ctx, pointA.x, pointA.y, pointB.x, pointB.y, radius);
        
        count = count + 1;
    }

    // 获取path
    CGContextClosePath(ctx);
    CGPathRef path = CGContextCopyPath(ctx);
    
    UIGraphicsEndImageContext();
    
    return path;
}



// 用于mask的layer
- (CAShapeLayer *) layer{
    CAShapeLayer *layer = [CAShapeLayer layer];
    layer.path = [self bubblePath];
    return layer;
}


#pragma mark - setup

// 设置默认参数
- (void)setDefaultProperty {
    
    _cornerRadius = 8;
    _arrowWidth = 30;
    _arrowHeight = 12;
    _arrowDirection = 1;
    _arrowPosition = 0.5;
    _arrowRadius = 3;
    
}

#pragma mark - init

-(instancetype)initWithSize:(CGSize) originalSize {
    if(self = [super init]) {
        [self setDefaultProperty];
        _size = originalSize;
    }
    return self;
}

@end
