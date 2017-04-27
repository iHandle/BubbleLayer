//
//  ViewController.m
//  Demo
//
//  Created by iHandle on 2017/4/27.
//  Copyright © 2017年 iHandle. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self.view setBackgroundColor:[UIColor groupTableViewBackgroundColor]];
    
    UIView *myView = [[UIView alloc]initWithFrame:CGRectMake(20, 30, 150, 100)];
    [myView.layer setBackgroundColor:[UIColor brownColor].CGColor];
    BubbleLayer *bubbleLayer = [[BubbleLayer alloc]initWithSize:myView.bounds.size];
    bubbleLayer.arrowDirection = ArrowDirectionTop;
    bubbleLayer.arrowHeight = 12;
    bubbleLayer.arrowWidth = 18;
    bubbleLayer.arrowPosition = 0.3;
    [myView.layer setMask:[bubbleLayer layer]];
    
    UIView *myView1 = [[UIView alloc]initWithFrame:CGRectMake(200, 50, 150, 300)];
    [myView1.layer setBackgroundColor:[UIColor purpleColor].CGColor];
    bubbleLayer = [[BubbleLayer alloc]initWithSize:myView1.bounds.size];
    bubbleLayer.arrowDirection = ArrowDirectionLeft;
    bubbleLayer.arrowHeight = 22;
    bubbleLayer.arrowWidth = 30;
    bubbleLayer.arrowPosition = 0.8;
    bubbleLayer.cornerRadius = 20;
    [myView1.layer setMask:[bubbleLayer layer]];
    
    UIView *myView2 = [[UIView alloc]initWithFrame:CGRectMake(30, 160, 130, 180)];
    [myView2.layer setBackgroundColor:[UIColor blackColor].CGColor];
    bubbleLayer = [[BubbleLayer alloc]initWithSize:myView2.bounds.size];
    bubbleLayer.arrowDirection = ArrowDirectionRight;
    bubbleLayer.arrowHeight = 20;
    bubbleLayer.arrowWidth = 37;
    bubbleLayer.arrowPosition = 0.1;
    bubbleLayer.cornerRadius = 15;
    [myView2.layer setMask:[bubbleLayer layer]];
    
    UIView *myView3 = [[UIView alloc]initWithFrame:CGRectMake(40, 400, 300, 200)];
    [myView3.layer setBackgroundColor:[UIColor darkGrayColor].CGColor];
    bubbleLayer = [[BubbleLayer alloc]initWithSize:myView3.bounds.size];
    bubbleLayer.arrowDirection = ArrowDirectionButtom;
    bubbleLayer.arrowHeight = 22;
    bubbleLayer.arrowWidth = 40;
    bubbleLayer.arrowPosition = 0.5;
    bubbleLayer.cornerRadius = 30;
    [myView3.layer setMask:[bubbleLayer layer]];
    
    [self.view addSubview:myView3];
    
    
    [self.view addSubview:myView2];
    
    
    [self.view addSubview:myView1];
    [self.view addSubview:myView];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
