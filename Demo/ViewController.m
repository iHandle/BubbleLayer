//
//  ViewController.m
//  Demo
//

#import "ViewController.h"

@interface ViewController ()

// 这些控件的一些参数在storyboard设置了
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UISegmentedControl *segCtrl;
@property (weak, nonatomic) IBOutlet UISlider *sdArrowHeight;
@property (weak, nonatomic) IBOutlet UISlider *sdArrowWidth;
@property (weak, nonatomic) IBOutlet UISlider *sdArrowRadius;
@property (weak, nonatomic) IBOutlet UISlider *sdCornerRadius;
@property (weak, nonatomic) IBOutlet UISlider *sdArrowPosition;
@property (weak, nonatomic) IBOutlet UISwitch *bbSwitch;

@property (strong, nonatomic) BubbleLayer *bbLayer;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    UIImage *image = [UIImage imageNamed:(@"Doraemon.jpeg")];
    _imageView.image = image;
    
    [_segCtrl addTarget:self action:@selector(segCtrlAction) forControlEvents:UIControlEventValueChanged];
    [_sdArrowHeight addTarget:self action:@selector(sliderAction:) forControlEvents:UIControlEventValueChanged];
    [_sdArrowWidth addTarget:self action:@selector(sliderAction:) forControlEvents:UIControlEventValueChanged];
    [_sdArrowRadius addTarget:self action:@selector(sliderAction:) forControlEvents:UIControlEventValueChanged];
    [_sdCornerRadius addTarget:self action:@selector(sliderAction:) forControlEvents:UIControlEventValueChanged];
    [_sdArrowPosition addTarget:self action:@selector(sliderAction:) forControlEvents:UIControlEventValueChanged];
    
    [_bbSwitch addTarget:self action:@selector(switchAction) forControlEvents:UIControlEventValueChanged];
    

  
}


- (void) segCtrlAction {
    NSInteger index =  _segCtrl.selectedSegmentIndex;
    ArrowDirection direction = (ArrowDirection)index;
    _bbLayer.arrowDirection = direction;
    _imageView.layer.mask = _bbLayer.layer;
    
}

- (void) sliderAction: (UISlider*)sender {
    if ([sender isEqual:_sdArrowHeight]) {
        _bbLayer.arrowHeight = _sdArrowHeight.value;
    } else if ([sender isEqual:_sdArrowWidth]) {
        _bbLayer.arrowWidth = _sdArrowWidth.value;
    } else if ([sender isEqual:_sdArrowRadius]) {
        _bbLayer.arrowRadius = _sdArrowRadius.value;
    } else if ([sender isEqual:_sdCornerRadius]) {
        _bbLayer.cornerRadius = _sdCornerRadius.value;
    } else if ([sender isEqual:_sdArrowPosition]) {
        _bbLayer.arrowPosition = _sdArrowPosition.value;
    }
    _imageView.layer.mask = _bbLayer.layer;
    
 }


- (void) switchAction {
    
    BOOL enabled = _bbSwitch.isOn;
    _segCtrl.enabled = enabled;
    _sdArrowHeight.enabled = enabled;
    _sdArrowWidth.enabled = enabled;
    _sdArrowRadius.enabled = enabled;
    _sdCornerRadius.enabled = enabled;
    _sdArrowPosition.enabled = enabled;

    if (enabled) {
        
        if(_bbLayer == nil) {
            _bbLayer = [[BubbleLayer alloc]initWithSize:_imageView.frame.size];
            _bbLayer.arrowDirection = (ArrowDirection)_segCtrl.selectedSegmentIndex;
            _bbLayer.arrowHeight = _sdArrowHeight.value;
            _bbLayer.arrowWidth = _sdArrowWidth.value;
            _bbLayer.arrowRadius = _sdArrowRadius.value;
            _bbLayer.cornerRadius = _sdCornerRadius.value;
            _bbLayer.arrowPosition = _sdArrowPosition.value;
            
        }
        
        _imageView.layer.mask = _bbLayer.layer;
    }
    else
        _imageView.layer.mask = nil;
    

}

    
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
