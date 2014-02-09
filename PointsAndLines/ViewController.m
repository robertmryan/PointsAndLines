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

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    CGRect frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.width);
    
    ChartPointView *view1 = [[ChartPointView alloc] initWithFrame:frame];
    view1.chartPoints = [self generateRandomPoints:100 forView:view1];
    [self.view addSubview:view1];
    
    ChartPointView *view2 = [[ChartPointView alloc] initWithFrame:frame];
    view2.chartPoints = [self generateRandomPoints:100 forView:view2];
    [self.view addSubview:view2];
    
    ChartPointView *view3 = [[ChartPointView alloc] initWithFrame:frame];
    view3.chartPoints = [self generateRandomPoints:10 forView:view3];
    view3.pointColor = [UIColor redColor];
    view3.chartType = kChartTypePoints;
    [self.view addSubview:view3];
    
    view2.alpha = 0.0;
    view2.transform = CGAffineTransformMakeScale(0.1, 0.1);
    view3.alpha = 0.0;

    [UIView animateWithDuration:0.5 delay:2.0 options:0 animations:^{
        view2.alpha = 1.0;
        view2.transform = CGAffineTransformIdentity;
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.5 delay:0.5 options:0 animations:^{
            view2.alpha = 0.0;
            view2.transform = CGAffineTransformMakeScale(3.0, 3.0);
        } completion:^(BOOL finished) {
            [view2 removeFromSuperview];
            [UIView animateWithDuration:0.5 delay:0.25 options:0 animations:^{
                view3.alpha = 1.0;
            } completion:nil];
        }];
    }];
}

- (NSArray *)generateRandomPoints:(NSInteger)count forView:(ChartPointView *)view
{
    NSMutableArray *points = [NSMutableArray array];
    CGPoint center = view.center;
    CGFloat pointRadius = 5.0;
    CGFloat width = view.frame.size.width - pointRadius * 2.0;
    CGFloat distance;
    
    while ([points count] < count) {
        CGPoint point = CGPointMake(arc4random_uniform(width) + pointRadius, arc4random_uniform(width) + pointRadius);
        distance = hypotf(point.x - center.x, point.y - center.y);
        if (distance < width / 2.0) {
            [points addObject:[ChartPoint chartPointWithCenter:point radius:pointRadius]];
        }
    }
    
    return points;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
