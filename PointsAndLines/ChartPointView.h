//
//  ChartPointView.h
//  PointsAndLines
//
//  Created by Robert Ryan on 2/7/14.
//  Copyright (c) 2014 Robert Ryan. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_OPTIONS(NSInteger, ChartType) {
    kChartTypeNone   = 0,
    kChartTypePoints = 1 << 0,
    kChartTypeLines  = 1 << 1
};

@interface ChartPointView : UIView

@property (nonatomic)         ChartType  chartType;
@property (nonatomic, strong) NSArray   *chartPoints;
@property (nonatomic, strong) UIColor   *pointColor;
@property (nonatomic)         CGFloat    maxDistance;

@end
