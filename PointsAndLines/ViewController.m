//
//  ViewController.m
//  PointsAndLines
//
//  Created by Robert Ryan on 2/7/14.
//  Copyright (c) 2014 Robert Ryan. All rights reserved.
//

#import "ViewController.h"
#import "ChartPointView.h"
#import "ChartPoint.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet ChartPointView *chartPointView;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.chartPointView.chartType = kChartTypePoints;

    self.chartPointView.chartPoints = @[[ChartPoint chartPointWithCenter:CGPointMake(20,80)  radius:5],
                                        [ChartPoint chartPointWithCenter:CGPointMake(120,60) radius:5],
                                        [ChartPoint chartPointWithCenter:CGPointMake(60,74)  radius:5],
                                        [ChartPoint chartPointWithCenter:CGPointMake(80,88)  radius:5],
                                        [ChartPoint chartPointWithCenter:CGPointMake(100,93) radius:5],
                                        [ChartPoint chartPointWithCenter:CGPointMake(20,20)  radius:5],
                                        [ChartPoint chartPointWithCenter:CGPointMake(160,70) radius:5],
                                        [ChartPoint chartPointWithCenter:CGPointMake(128,68) radius:5],
                                        [ChartPoint chartPointWithCenter:CGPointMake(90,60)  radius:5],
                                        [ChartPoint chartPointWithCenter:CGPointMake(110,80) radius:5]];

    double delayInSeconds = 3.0;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){

        // I'm going to change the chart type, but I'm going to cross dissolve it to make it less jarring

        [UIView transitionWithView:self.chartPointView duration:0.2 options:UIViewAnimationOptionTransitionCrossDissolve animations:^{
            self.chartPointView.chartType = kChartTypePoints | kChartTypeLines;
        } completion:nil];
    });
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
