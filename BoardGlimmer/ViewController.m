//
//  ViewController.m
//  BoardGlimmer
//
//  Created by Han Mingjie on 2020/7/14.
//  Copyright © 2020 MingJie Han. All rights reserved.
//

#import "ViewController.h"

@interface ViewController (){
    UIView *your_view;
    UIColor *board_color;
    
    UISlider *widthOfLineSlider;
    UILabel *widthOfLineLabel;
    UISlider *numOfLinesSlider;
    UILabel *numOfLinesLabel;
    UISlider *distanceOfLineSlider;
    UILabel *distanceOfLineLabel;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Board Glimmer";
    self.view.backgroundColor = [UIColor whiteColor];
    board_color = [UIColor colorWithRed:(random()%255)/255.f green:(random()%255)/255.f blue:(random()%255)/255.f alpha:1.f];
    your_view = [[UIView alloc] initWithFrame:CGRectMake(0.f, 0.f, 100.f, 100.f)];
    your_view.autoresizingMask = UIViewAutoresizingFlexibleTopMargin|UIViewAutoresizingFlexibleLeftMargin|UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin;
    your_view.center = self.view.center;
    [self.view addSubview:your_view];
    
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    your_view.center = self.view.center;
    your_view.backgroundColor = [UIColor colorWithRed:(random()%255)/255.f green:(random()%255)/255.f blue:(random()%255)/255.f alpha:1.f];
}


-(void)numOfLinesSliderChanged:(id)sender{
    numOfLinesLabel.text = [NSString stringWithFormat:@"Line Number:%.0f",numOfLinesSlider.value];
    [self refresh];
}

-(void)distanceOfLineSliderChanged:(id)sender{
    distanceOfLineLabel.text = [NSString stringWithFormat:@"Line Space:%.1f",distanceOfLineSlider.value];
    [self refresh];
}
-(void)widthOfLineSliderChanged:(id)sender{
    widthOfLineLabel.text = [NSString stringWithFormat:@"Board Width:%.1f",widthOfLineSlider.value];
    [self refresh];
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
    if (nil == numOfLinesSlider){
        numOfLinesSlider = [[UISlider alloc] initWithFrame:CGRectMake(210.f, self.view.frame.size.height-60.f, self.view.frame.size.width-220.f, 30.f)];
        numOfLinesSlider.minimumValue = 1;
        numOfLinesSlider.maximumValue = 10;
        numOfLinesSlider.value = 3;
        [numOfLinesSlider addTarget:self action:@selector(numOfLinesSliderChanged:) forControlEvents:UIControlEventValueChanged];
        numOfLinesSlider.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleTopMargin;
        [self.view addSubview:numOfLinesSlider];
        
        numOfLinesLabel = [[UILabel alloc] initWithFrame:CGRectMake(10.f, numOfLinesSlider.frame.origin.y, 200.f, numOfLinesSlider.frame.size.height)];
        numOfLinesLabel.autoresizingMask = UIViewAutoresizingFlexibleTopMargin;
        numOfLinesLabel.textColor = [UIColor blackColor];
        numOfLinesLabel.backgroundColor = [UIColor clearColor];
        numOfLinesLabel.text = [NSString stringWithFormat:@"Line Number:%.0f",numOfLinesSlider.value];
        [self.view addSubview:numOfLinesLabel];
    }
    
    if (nil == distanceOfLineSlider){
        distanceOfLineSlider = [[UISlider alloc] initWithFrame:CGRectMake(210.f, self.view.frame.size.height-100.f, self.view.frame.size.width-220.f, 30.f)];
        distanceOfLineSlider.minimumValue = 2.f;
        distanceOfLineSlider.maximumValue = 10.f;
        distanceOfLineSlider.value = 3.f;
        [distanceOfLineSlider addTarget:self action:@selector(distanceOfLineSliderChanged:) forControlEvents:UIControlEventValueChanged];
        distanceOfLineSlider.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleTopMargin;
        [self.view addSubview:distanceOfLineSlider];
        
        distanceOfLineLabel = [[UILabel alloc] initWithFrame:CGRectMake(10.f, distanceOfLineSlider.frame.origin.y, 200.f, distanceOfLineSlider.frame.size.height)];
        distanceOfLineLabel.autoresizingMask = UIViewAutoresizingFlexibleTopMargin;
        distanceOfLineLabel.textColor = [UIColor blackColor];
        distanceOfLineLabel.backgroundColor = [UIColor clearColor];
        distanceOfLineLabel.text = [NSString stringWithFormat:@"Line Space:%.1f",distanceOfLineSlider.value];
        [self.view addSubview:distanceOfLineLabel];
    }
    
    if (nil == widthOfLineSlider){
        widthOfLineSlider = [[UISlider alloc] initWithFrame:CGRectMake(210.f, self.view.frame.size.height-140.f, self.view.frame.size.width-220.f, 30.f)];
        widthOfLineSlider.minimumValue = 0.1f;
        widthOfLineSlider.maximumValue = 4.f;
        widthOfLineSlider.value = 0.5f;
        [widthOfLineSlider addTarget:self action:@selector(widthOfLineSliderChanged:) forControlEvents:UIControlEventValueChanged];
        widthOfLineSlider.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleTopMargin;
        [self.view addSubview:widthOfLineSlider];
        
        widthOfLineLabel = [[UILabel alloc] initWithFrame:CGRectMake(10.f, widthOfLineSlider.frame.origin.y, 200.f, widthOfLineSlider.frame.size.height)];
        widthOfLineLabel.autoresizingMask = UIViewAutoresizingFlexibleTopMargin;
        widthOfLineLabel.textColor = [UIColor blackColor];
        widthOfLineLabel.backgroundColor = [UIColor clearColor];
        widthOfLineLabel.text = [NSString stringWithFormat:@"Board Width:%.1f",widthOfLineSlider.value];
        [self.view addSubview:widthOfLineLabel];
    }
    
    [self refresh];
}



-(void)refresh{
    while (your_view.layer.sublayers.count > 0) {
        [your_view.layer.sublayers.firstObject removeFromSuperlayer];
    }
    
    float distance = distanceOfLineSlider.value;
    float start = 1.f;
    for (int i=1;i<=numOfLinesSlider.value;i++){
        [self makeLayerWithDistance:start+distance*i];
    }
}

-(CABasicAnimation *)opacityForever_Animation:(float)time{
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"opacity"];
    animation.fromValue = [NSNumber numberWithFloat:1.0f];
    animation.toValue = [NSNumber numberWithFloat:0.1f];
    animation.autoreverses = YES;
    animation.duration = time;
    animation.repeatCount = MAXFLOAT;
    animation.removedOnCompletion = NO;
    animation.fillMode = kCAFillModeForwards;
    animation.timingFunction=[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
    return animation;
}

-(void)makeLayerWithDistance:(float)distance{
    CGSize radi = CGSizeMake(5, 5);
    CGRect rect = CGRectMake(your_view.bounds.origin.x-distance, your_view.bounds.origin.y-distance, your_view.bounds.size.width+2*distance, your_view.bounds.size.height+2*distance);
    
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:rect byRoundingCorners:UIRectCornerAllCorners cornerRadii:radi];
    
    CAShapeLayer *borderLayer = [CAShapeLayer layer];
    borderLayer.path= maskPath.CGPath;
    borderLayer.lineWidth = widthOfLineSlider.value;
    borderLayer.fillColor = [UIColor clearColor].CGColor;
    borderLayer.strokeColor = board_color.CGColor;
    borderLayer.frame = your_view.bounds;
    [borderLayer addAnimation:[self opacityForever_Animation:0.5] forKey:nil];
    [your_view.layer addSublayer:borderLayer];
}

@end
