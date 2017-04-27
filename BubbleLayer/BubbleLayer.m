//
//  BubbleLayer.m
//  Bubble
//
//  Created by iHandle on 2017/4/26.
//  Copyright © 2017年 iHandle. All rights reserved.
//

#import "BubbleLayer.h"


@interface BubbleLayer()
// 箭头的三个点
@property (nonatomic) NSMutableArray *arrowPoints;
// 开始画圆角的点：对应角顺序是：右下、左下，左上，右上
@property (nonatomic) NSMutableArray *keyPointAtcorner;
// 圆角的圆心，顺序对应上面圆角的顺序
@property (nonatomic) NSMutableArray *centerOfCorner;

@property (nonatomic) CGRect contentFrame;
//@property (nonatomic) CGRect frame;
@property (nonatomic) CGSize size;


@end

@implementation BubbleLayer



#pragma mark - getter
- (NSMutableArray *) arrowPoints {
    CGPoint beginPoint;
    CGPoint headPoint;
    CGPoint endPoint;
    
    // 箭头 纵向/横向的可调长度
    CGFloat validWidthForHead = _size.width - 2 * _cornerRadius - _arrowWidth;
    CGFloat validHeightForHead = _size.height - 2 * _cornerRadius - _arrowWidth;
    
    switch (_arrowDirection) {
            
            //右
        case ArrowDirectionRight:  //以中间作基准
            headPoint = CGPointMake(_size.width , _size.height / 2 + validHeightForHead*(_arrowPosition - 0.5));
            beginPoint = CGPointMake(headPoint.x - _arrowHeight, headPoint.y - _arrowWidth/2);
            endPoint = CGPointMake(beginPoint.x, beginPoint.y + _arrowWidth);
            break;
            
            //下
        case ArrowDirectionButtom:
            headPoint = CGPointMake(_size.width / 2 + validWidthForHead*(_arrowPosition - 0.5), _size.height);
            beginPoint = CGPointMake(headPoint.x + _arrowWidth/2, headPoint.y - _arrowHeight);
            endPoint = CGPointMake(beginPoint.x - _arrowWidth, beginPoint.y);
            break;
            
            // 左
        case ArrowDirectionLeft:
            headPoint = CGPointMake(0, _size.height / 2 + validHeightForHead*(_arrowPosition - 0.5));
            beginPoint = CGPointMake(headPoint.x + _arrowHeight, headPoint.y + _arrowWidth/2);
            endPoint = CGPointMake(beginPoint.x, beginPoint.y - _arrowWidth);
            break;
            
            //上
        case ArrowDirectionTop:
            headPoint = CGPointMake(_size.width / 2 + validWidthForHead*(_arrowPosition - 0.5), 0);
            beginPoint = CGPointMake(headPoint.x - _arrowWidth/2, headPoint.y + _arrowHeight);
            endPoint = CGPointMake(beginPoint.x + _arrowWidth, beginPoint.y);
            break;
    }
    
    _arrowPoints = [NSMutableArray arrayWithObjects:[NSValue valueWithCGPoint:beginPoint],
                    [NSValue valueWithCGPoint:headPoint],
                    [NSValue valueWithCGPoint:endPoint],  nil];
    
    return _arrowPoints;
}

- (NSMutableArray *) keyPointAtcorner {
    
    CGRect cFrame = [self contentFrame];
    
    CGPoint buttomRight = CGPointMake(CGRectGetMaxX(cFrame), CGRectGetMaxY(cFrame) - _cornerRadius);
    CGPoint buttomLeft = CGPointMake(CGRectGetMinX(cFrame) + _cornerRadius, CGRectGetMaxY(cFrame));
    CGPoint topLeft = CGPointMake(CGRectGetMinX(cFrame), CGRectGetMinY(cFrame) + _cornerRadius);
    CGPoint topRight = CGPointMake(CGRectGetMaxX(cFrame) - _cornerRadius, CGRectGetMinY(cFrame));
    
    
    _keyPointAtcorner = [NSMutableArray arrayWithObjects: [NSValue valueWithCGPoint:buttomRight],
                         [NSValue valueWithCGPoint:buttomLeft],
                         [NSValue valueWithCGPoint:topLeft],
                         [NSValue valueWithCGPoint:topRight],  nil];
    
    return _keyPointAtcorner;
}

- (NSMutableArray *) centerOfCorner {
    
    CGRect cFrame = [self contentFrame];
    
    CGPoint buttomRight = CGPointMake(CGRectGetMaxX(cFrame) - _cornerRadius, CGRectGetMaxY(cFrame) - _cornerRadius);
    CGPoint buttomLeft = CGPointMake(CGRectGetMinX(cFrame) + _cornerRadius, CGRectGetMaxY(cFrame) - _cornerRadius);
    CGPoint topLeft = CGPointMake(CGRectGetMinX(cFrame) + _cornerRadius, CGRectGetMinY(cFrame) + _cornerRadius);
    CGPoint topRight = CGPointMake(CGRectGetMaxX(cFrame) - _cornerRadius, CGRectGetMinY(cFrame) + _cornerRadius);
    
    _centerOfCorner = [NSMutableArray arrayWithObjects: [NSValue valueWithCGPoint:buttomRight],
                       [NSValue valueWithCGPoint:buttomLeft],
                       [NSValue valueWithCGPoint:topLeft],
                       [NSValue valueWithCGPoint:topRight],  nil];
    
    return _centerOfCorner;
}

- (CGRect)contentFrame {
    
    CGFloat x = 0, y = 0;
    CGFloat width = _size.width, height = _size.height;
    
    switch (_arrowDirection) {
        case ArrowDirectionRight:
            width -= _arrowHeight;
            break;
        case ArrowDirectionButtom:
            height -= _arrowHeight;
            break;
        case ArrowDirectionLeft:
            x = _arrowHeight;
            width -= _arrowHeight;
            break;
        case ArrowDirectionTop:
            y = _arrowHeight;
            height -= _arrowHeight;
            break;
    }
    
    _contentFrame = CGRectMake(x, y, width, height);
    return _contentFrame;
}

#pragma mark - draw

// 绘制气泡形状
- (UIBezierPath *)bubblePath {
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    NSMutableArray *arrow = [self arrowPoints];
    NSMutableArray *keyPoints = [self keyPointAtcorner];
    NSMutableArray *centers = [self centerOfCorner];
    
    // 第一个被绘制的角在数组中的下标
    int currentCorner;
    
    switch (_arrowDirection) {
            
        case ArrowDirectionRight:
            currentCorner = 0;
            break;
        case ArrowDirectionButtom:
            currentCorner = 1;
            break;
        case ArrowDirectionLeft:
            currentCorner = 2;
            break;
        case ArrowDirectionTop:
            currentCorner = 3;
            break;
    }
    
    
    // 先画箭头，顺时针画
    
    CGPoint nextPoint = [[arrow objectAtIndex:0] CGPointValue];
    [path moveToPoint:CGPointMake(nextPoint.x, nextPoint.y)];
    // 箭头顶点
    nextPoint = [[arrow objectAtIndex:1] CGPointValue];
    [path addLineToPoint:CGPointMake(nextPoint.x, nextPoint.y)];
    
    nextPoint = [[arrow objectAtIndex:2] CGPointValue];
    [path addLineToPoint:CGPointMake(nextPoint.x, nextPoint.y)];
    
    // 用来画圆角的圆心
    CGPoint nextCenter;
    
    for(int i=0; i<4; i++) {
        
        // 连到开始画圆角的点
        nextPoint = [[keyPoints objectAtIndex:currentCorner] CGPointValue];
        [path addLineToPoint:CGPointMake(nextPoint.x, nextPoint.y)];
        
        // 画圆角
        nextCenter = [[centers objectAtIndex:currentCorner] CGPointValue];
        [path addArcWithCenter:nextCenter radius:_cornerRadius
                    startAngle: currentCorner * M_PI / 2 endAngle:(currentCorner+1) * M_PI / 2  clockwise:YES];
        // 准备下一个圆角
        currentCorner = (currentCorner + 1)%4;
    }
    
    return path;
}


#pragma mark - setup

- (void)setDefaultProperty {
    _cornerRadius = 10;
    _arrowWidth = 10;
    _arrowHeight = 10;
    _arrowDirection = ArrowDirectionButtom;
    _arrowPosition = 0.5;
    
}

- (CAShapeLayer *) layer{
    UIBezierPath *path = [self bubblePath];
    CAShapeLayer *layer = [CAShapeLayer layer];
    layer.path = path.CGPath;
    return layer;
}



-(instancetype)initWithSize:(CGSize)size {
    if(self = [super init]) {
        [self setDefaultProperty];
        _size = size;
    }
    return self;
}




@end
