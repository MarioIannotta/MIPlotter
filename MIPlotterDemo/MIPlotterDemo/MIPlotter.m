//
//  MIPlotter.m
//  TrainingTime2
//
//  Created by Mario Iannotta on 09/02/14.
//  Copyright (c) 2014 Mario Iannotta. All rights reserved.
//

#import "MIPlotter.h"
#import "MISinglePlot.h"

@implementation MIPlotter

- (id)initInView:(UIView *)view {
    
    self = [super init];
    
    if (self) {
        
        self.backgroundView = view;
        
        self.plotList = [[NSMutableArray alloc] init];
        self.decimationCoeff = 1;
        
        self.backLineColor = [UIColor colorWithWhite:0 alpha:0.2];
        self.labelColor = [UIColor colorWithWhite:0 alpha:0.3];
        
        self.pointRadius = 10;
        self.lineWidth = 2;
        
        self.xPadding = 40;
        self.yPadding = 30;
        
        self.xLabelHeight = 10;
        self.yLabelWidth = 20;
        
        self.xLabelOffset = 0;
        self.yLabelOffset = 10;
        
        self.yNumberDivision = 8;
    }
    
    return self;
}

- (BOOL)addPlotOf:(NSArray *)values withLineColor:(UIColor *)lineColor fillColor:(UIColor *)fillColor andID:(NSString *)plotID {
    
    if ([self existsPlotWithID:plotID]) return NO;

    MISinglePlot *plot = [[MISinglePlot alloc] initWithValues:values andPlotter:self];
    
    [plot setFillColor:fillColor];
    [plot setLineColor:lineColor];
    [plot setPlotter:self];
    [plot setYMax:[self max:plot.values]];
    
    [self.plotList addObject:@{@"plot": plot, @"ID": plotID}];
    
    return YES;
    
}
- (BOOL)removePlotWithID:(NSString *)plotID {
    
    for (int i = 0; i < self.plotList.count; i++) {
        
        if ([[[self.plotList objectAtIndex:i] objectForKey:@"ID"] isEqualToString:plotID]) {
            
            [self.plotList removeObjectAtIndex:i];
            return YES;
        }
    }
    
    return NO;
}
- (BOOL)existsPlotWithID:(NSString *)plotID {

    for (int i = 0; i < self.plotList.count; i++)
        if ([[[self.plotList objectAtIndex:i] objectForKey:@"ID"] isEqualToString:plotID]) return YES;
        
    return NO;
}
- (void)drawAllPlots {
    
    [self calcTheYMaxOfAllPlot];
    [self initNewPlots];
    
}
- (void)drawAllPlotsWithYMax:(float)yMax {
    
    [self setYMax:yMax];
    [self initNewPlots];
}
- (void)initNewPlots {
    
    for (int i = 0; i < self.plotList.count; i++) {
        
        NSDictionary *plotDic = [self.plotList objectAtIndex:self.plotList.count-i-1];
        MISinglePlot *plot = [plotDic objectForKey:@"plot"];
        [self.plotList removeObject:plotDic];
        
        MISinglePlot *realPlot = [[MISinglePlot alloc] initWithFrame:CGRectMake(0, 0, self.backgroundView.frame.size.width, self.backgroundView.frame.size.height) andValues:plot.values];
        
        [realPlot setLineColor:plot.lineColor];
        [realPlot setFillColor:plot.fillColor];
        [realPlot setPlotter:self];
        
        [self.plotList addObject:@{@"plot": realPlot, @"ID": [plotDic objectForKey:@"ID"]}];
        [self.backgroundView addSubview:realPlot];
        
    }
    
}
- (float)max:(NSArray *)values {
    
    float max = [values[0] floatValue];
    
    for (int i = 1; i < values.count; i++)
        if ([values[i] floatValue] > max) max = [values[i] floatValue];
    
    return max;
}
- (void)calcTheYMaxOfAllPlot {
    
    MISinglePlot *initialPlot = [[self.plotList objectAtIndex:0] objectForKey:@"plot"];
    [self setYMax: [self max:initialPlot.values]];
    
    for (int i = 0; i < self.plotList.count; i++) {
        
        MISinglePlot *plot = [[self.plotList objectAtIndex:i] objectForKey:@"plot"];
        float tmpYMax = [self max:plot.values];
        
        if (self.yMax < tmpYMax) self.yMax = tmpYMax;
        
    }
    
}
- (void)setLabelForXValues:(NSArray *)xLabels {
    
    if ([self areLabelsConsistent:xLabels]) {
        
        [self setXLabels:xLabels];
        
    } else {
        
        NSLog(@"ERROR: the number of the labels isn't equal to the number of values; the x labels will not be displayed");
    }
}
- (BOOL)areLabelsConsistent:(NSArray *)xLabels { // check if the number of the labels is equal to the number of values.
    
    for (int i = 0; i < self.plotList.count; i++) {
        
        NSDictionary *plotDic = [self.plotList objectAtIndex:self.plotList.count-i-1];
        MISinglePlot *plot = [plotDic objectForKey:@"plot"];
        
        if (plot.values.count != xLabels.count) return NO;
    }
    return YES;
    
}

@end
