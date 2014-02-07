//
//  ChartPoint.h
//  PointsAndLines
//
//  Created by Robert Ryan on 2/7/14.
//  Copyright (c) 2014 Robert Ryan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ChartPoint : NSObject

@property (nonatomic) CGPoint center;
@property (nonatomic) CGFloat radius;

+ (instancetype) chartPointWithCenter:(CGPoint)center radius:(CGFloat)radius;
- (CGFloat)distanceToPoint:(ChartPoint *)otherPoint;

@end
