//
//  ChartPoint.m
//  PointsAndLines
//
//  Created by Robert Ryan on 2/7/14.
//  Copyright (c) 2014 Robert Ryan. All rights reserved.
//

#import "ChartPoint.h"

@implementation ChartPoint

+ (instancetype) chartPointWithCenter:(CGPoint)center radius:(CGFloat)radius
{
    ChartPoint *chartPoint = [[ChartPoint alloc] init];
    chartPoint.center = center;
    chartPoint.radius = radius;

    return chartPoint;
}

- (CGFloat)distanceToPoint:(ChartPoint *)otherPoint
{
    return hypotf(self.center.x - otherPoint.center.x, self.center.y - otherPoint.center.y);
}

@end
