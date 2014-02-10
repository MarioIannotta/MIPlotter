//
//  MISinglePlot.h
//  TrainingTime2
//
//  Created by Mario Iannotta on 09/02/14.
//  Copyright (c) 2014 Mario Iannotta. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MIPlotter.h"

@interface MISinglePlot : UIView

@property (assign, nonatomic) CGRect container;
@property (strong, nonatomic) NSArray *values;
@property (strong, nonatomic) UIView *xLabelView, *yLabelView;
@property (strong, nonatomic) UIColor *lineColor, *fillColor;
@property (assign, nonatomic) float xPadding, yPadding, yMax, axesWidth, yLabelWidth, xLabelHeight;
@property (assign, nonatomic) int yNumberDivision;
@property (assign, nonatomic) BOOL showPoints, showXAxis, showYAxis, showXLabel, showYLabel;
@property (strong, nonatomic) MIPlotter *plotter;

- (id)initWithValues:(NSArray *)values andPlotter:(MIPlotter *)plotter;
- (id)initWithFrame:(CGRect)frame andValues:(NSArray *)values;

@end
