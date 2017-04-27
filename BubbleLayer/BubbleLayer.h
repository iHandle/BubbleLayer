//
//  BubbleLayer.h
//  Bubble
//
//  Created by iHandle on 2017/4/26.
//  Copyright © 2017年 iHandle. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef enum {
    ArrowDirectionTop,
    ArrowDirectionButtom,
    ArrowDirectionLeft,
    ArrowDirectionRight,
} ArrowDirection;

@interface BubbleLayer : NSObject

@property CGFloat cornerRadius;
@property CGFloat arrowHeight;
@property CGFloat arrowWidth;
@property ArrowDirection arrowDirection;
// 箭头的位置 0表示最左／上，1表示最右／下
@property CGFloat arrowPosition;

- (instancetype) initWithSize:(CGSize) size;

- (CAShapeLayer *) layer;
@end
