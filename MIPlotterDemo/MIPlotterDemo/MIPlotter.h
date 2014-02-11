//
//  MIPlotter.h
//  TrainingTime2
//
//  Created by Mario Iannotta on 09/02/14.
//  Copyright (c) 2014 Mario Iannotta. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MIPlotter : NSObject

@property (strong, nonatomic) UIView *backgroundView;
@property (strong, nonatomic) NSMutableArray *plotList;
@property (strong, nonatomic) UIColor *backLineColor, *labelColor;
@property (strong, nonatomic) NSArray *xLabels;
@property (assign, nonatomic) float xPadding, yPadding, yMax, pointRadius, lineWidth, yLabelWidth, xLabelHeight, xLabelOffset, yLabelOffset;
@property (assign, nonatomic) int decimationCoeff, yNumberDivision;

- (id)initInView:(UIView *)view;

- (BOOL)addPlotOf:(NSArray *)values withLineColor:(UIColor *)lineColor fillColor:(UIColor *)fillColor andID:(NSString *)plotID;
- (BOOL)removePlotWithID:(NSString *)plotID;
- (void)drawAllPlots;
- (void)drawAllPlotsWithYMax:(float)yMax;
- (void)setLabelForXValues:(NSArray *)xLabels;

@end
