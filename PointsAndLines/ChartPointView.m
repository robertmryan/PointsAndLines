//
//  ChartPointView.m
//  PointsAndLines
//
//  Created by Robert Ryan on 2/7/14.
//  Copyright (c) 2014 Robert Ryan. All rights reserved.
//

#import "ChartPointView.h"
#import "ChartPoint.h"

@implementation ChartPointView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        self.chartType = kChartTypeLines | kChartTypePoints;
        self.maxDistance = frame.size.width / 5.0;
    }
    
    return self;
}

- (void)drawRect:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();

    CGContextSetFillColorWithColor(context, [self.pointColor CGColor]);
    CGContextSetStrokeColorWithColor(context, [self.pointColor CGColor]);

    // draw the points, if the `chartType` specifies to do so

    if (self.chartType & kChartTypePoints) {
        for (ChartPoint *chartPoint in self.chartPoints) {
            [self context:context addChartPoint:chartPoint];
        }

        CGContextDrawPath(context, kCGPathFill);
    }

    // draw the lines, if the `chartType` specifies to do so

    if (self.chartType & kChartTypeLines) {
        [self context:context addLinesToClosestPoints:3];

        CGContextSetLineWidth(context, 1);
        CGContextDrawPath(context, kCGPathStroke);
    }
}

- (void)context:(CGContextRef)context addChartPoint:(ChartPoint *)chartPoint
{
    CGContextMoveToPoint(context, chartPoint.center.x, chartPoint.center.y);
    CGContextAddArc(context, chartPoint.center.x, chartPoint.center.y, chartPoint.radius, 0, M_PI * 2.0, YES);
}

- (void)context:(CGContextRef)context addLineFromChartPoint:(ChartPoint *)chartPoint1 toChartPoint:(ChartPoint *)chartPoint2
{
    CGContextMoveToPoint(context, chartPoint1.center.x, chartPoint1.center.y);
    CGContextAddLineToPoint(context, chartPoint2.center.x, chartPoint2.center.y);
}

- (void)context:(CGContextRef)context addLinesToClosestPoints:(NSInteger)numberOfLines
{
    [self.chartPoints enumerateObjectsUsingBlock:^(ChartPoint *chartPoint, NSUInteger idx, BOOL *stop) {

        // build new array of indices sorted by distance from the current point

        NSArray *sortedChartPoints = [self.chartPoints sortedArrayUsingComparator:^NSComparisonResult(ChartPoint *point1, ChartPoint *point2) {

            CGFloat distance1 = [chartPoint distanceToPoint:point1];
            CGFloat distance2 = [chartPoint distanceToPoint:point2];

            if (distance1 < distance2)
                return NSOrderedAscending;
            else if (distance1 > distance2)
                return NSOrderedDescending;
            return NSOrderedSame;
        }];

        // now draw lines to the three closest points
        // (skipping 0, because that's probably the current point)

        for (NSInteger i = 1; i <= numberOfLines && i < [sortedChartPoints count]; i++) {
            CGFloat distance = [chartPoint distanceToPoint:sortedChartPoints[i]];
            
            if (distance <= self.maxDistance)
                [self context:context addLineFromChartPoint:chartPoint toChartPoint:sortedChartPoints[i]];
        }
    }];
}

#pragma mark - Setters that automatically flag the view as needing to be redrawn

- (void)setChartType:(ChartType)chartType
{
    _chartType = chartType;
    [self setNeedsDisplay];
}

- (void)setChartPoints:(NSArray *)chartPoints
{
    _chartPoints = chartPoints;
    [self setNeedsDisplay];
}

- (void)setPointColor:(UIColor *)pointColor
{
    _pointColor = pointColor;
    [self setNeedsDisplay];
}

- (void)setMaxDistance:(CGFloat)maxDistance
{
    _maxDistance = maxDistance;
    [self setNeedsDisplay];
}

@end
