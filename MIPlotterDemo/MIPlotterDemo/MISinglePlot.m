//
//  MISinglePlot.m
//  TrainingTime2
//
//  Created by Mario Iannotta on 09/02/14.
//  Copyright (c) 2014 Mario Iannotta. All rights reserved.
//

#import "MISinglePlot.h"
#import <QuartzCore/QuartzCore.h>

#define debug 0
#define xOffset 0.2 // need it for fix the space between the fill blocks
#define minXLabelHeight 10
#define minYLabelWidth 20

@implementation MISinglePlot

- (id)initWithValues:(NSArray *)values andPlotter:(MIPlotter *)plotter {
    
    self = [super init];
    
    if (self) {
        
        self.values = values;
        self.plotter = plotter;
        
    }
    return self;
}
- (id)initWithFrame:(CGRect)frame andValues:(NSArray *)values {
    
    self = [super initWithFrame:frame];
    
    if (self) {
        
        self.container = frame;
        self.values = values;
        
        [self setBackgroundColor:[UIColor clearColor]];
        
        self.lineColor = [UIColor colorWithRed:7/255.0 green:118/255.0 blue:179/255.0 alpha:1];
        self.fillColor = [UIColor colorWithRed:126/255.0 green:187/255.0 blue:221/255.0 alpha:0.5];
        
    }
    
    return self;
}

- (void)drawRect:(CGRect)rect {
    
    [self addAxesLabels];
    
    NSMutableArray *pointsArray = [[NSMutableArray alloc] init];
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetLineWidth(context, self.plotter.lineWidth);
    
    [self drawAxesInContext:context];
    
    for (int i = 0; i < self.values.count; i++) {
        
        CGPoint firstPoint = [self pointForX:i andY:[[self.values objectAtIndex:i] floatValue]];
        
        if (i < self.values.count - 1) {
            
            CGPoint secondPoint = [self pointForX:i + 1  andY:[[self.values objectAtIndex:i + 1] floatValue]];
            [self drawPathTopLeft:firstPoint topRight:secondPoint bottomLeft:[self pointForX:i andY:0] bottomRight:[self pointForX:i + 1 andY:0] inContext:context];
        }
        
        if (self.plotter.pointRadius != 0) [self drawPoint:firstPoint inContext:context];
        
        [pointsArray addObject:[NSValue valueWithCGPoint:firstPoint]];
    }
    
    [self drawLineForPoints:pointsArray withWidth:self.plotter.lineWidth andColor:self.lineColor inContext:context dotted:NO];
}

- (void)drawPoint:(CGPoint)point inContext:(CGContextRef)context {
    
    CGContextSetFillColorWithColor(context, self.lineColor.CGColor);
    
    if (debug) NSLog(@"drawing point in (%g,%g)", point.x, point.y);
                     
    CGRect frame = CGRectMake(point.x - self.plotter.pointRadius/2, point.y - self.plotter.pointRadius/2, self.plotter.pointRadius, self.plotter.pointRadius);
    
    CGContextAddEllipseInRect(context, frame);
    CGContextEOFillPath(context);
}
- (void)drawLineForPoints:(NSMutableArray *)points withWidth:(float)width andColor:(UIColor *)color inContext:(CGContextRef)context dotted:(BOOL)dotted {
    
    CGContextSetLineWidth(context, width);
    CGContextSetStrokeColorWithColor(context, color.CGColor);
    
    CGContextMoveToPoint(context, [[points objectAtIndex:0] CGPointValue].x, [[points objectAtIndex:0] CGPointValue].y);
    
    if (dotted) {
        
        CGFloat dash[] = {3.0, 3.0};
        CGContextSetLineDash(context, 0.0, dash, 1);
        
    } else CGContextSetLineDash(context, 0.0, nil, 0);
    
    for (int i = 1; i < points.count; i++)
        CGContextAddLineToPoint(context, [[points objectAtIndex:i] CGPointValue].x, [[points objectAtIndex:i] CGPointValue].y);
    
    CGContextStrokePath(context);
    
}
- (void)drawLineFrom:(CGPoint)firstPoint to:(CGPoint)secondPoint inContext:(CGContextRef)context ofWidth:(float)width andColor:(UIColor *)color dotted:(BOOL)dotted {
    
    if (debug) NSLog(@"drawing from (%g,%g) to (%g, %g)", firstPoint.x, firstPoint.y, secondPoint.x, secondPoint.y);
    
    CGContextSetLineWidth(context, width);
    CGContextSetStrokeColorWithColor(context, color.CGColor);
    
    CGContextMoveToPoint(context, firstPoint.x, firstPoint.y);
    CGContextAddLineToPoint(context, secondPoint.x, secondPoint.y);
    
    if (dotted) {
        
        CGFloat dash[] = {3.0, 3.0};
        CGContextSetLineDash(context, 0.0, dash, 1);
        
    }
    
    CGContextStrokePath(context);
    
}
- (void)drawPathTopLeft:(CGPoint)topLeftPoint topRight:(CGPoint)topRightPoint bottomLeft:(CGPoint)bottomLeftPoint bottomRight:(CGPoint)bottomRightPoint inContext:(CGContextRef)context {
    
    CGContextSetFillColorWithColor(context, self.fillColor.CGColor);
    
    CGContextMoveToPoint(context, topLeftPoint.x, topLeftPoint.y);
    CGContextAddLineToPoint(context, topRightPoint.x + xOffset, topRightPoint.y + xOffset);
    CGContextAddLineToPoint(context, bottomRightPoint.x + xOffset, bottomRightPoint.y);
    CGContextAddLineToPoint(context, bottomLeftPoint.x, bottomLeftPoint.y);
    CGContextSetFillColorWithColor(context, self.fillColor.CGColor);
    
    CGContextFillPath(context);
}
- (void)drawAxesInContext:(CGContextRef)context {
    
    for (int i = 1; i < self.plotter.yNumberDivision + 1; i++) {
        
        float actualY = self.plotter.yMax/self.plotter.yNumberDivision * i;
        
        CGPoint firstPoint = CGPointMake([self pointForX:0 andY:0].x, [self pointForX:0 andY:actualY].y);
        CGPoint secondPoint = CGPointMake(self.yLabelView.frame.origin.x, firstPoint.y);
        
        [self drawLineFrom:firstPoint to:secondPoint inContext:context ofWidth:0.2 andColor:self.plotter.backLineColor dotted:YES];
        
        [self drawYLabel:[NSString stringWithFormat:@"%g",actualY] atY:firstPoint.y inView:self.yLabelView];
    }
    
    for (int i = 0; i < self.plotter.xLabels.count; i++) {
        
        if (i % self.plotter.decimationCoeff == 0) {
            CGPoint firstPoint = [self pointForX:i andY:0];
            [self drawXLabel:[self.plotter.xLabels objectAtIndex:i] atX:firstPoint.x inView:self.xLabelView];
        }
        
    }
    
}
- (void)addAxesLabels {
    
    if (self.plotter.yLabelWidth != 0) {
        
        CGRect tmpFrame = self.container;
        tmpFrame.size.width -= MAX(self.plotter.yLabelWidth, minYLabelWidth);
        self.container = tmpFrame;
        
        self.yLabelView = [[UIView alloc] initWithFrame:CGRectMake(tmpFrame.size.width - self.plotter.xPadding/2,
                                                                   self.plotter.yPadding/2,
                                                                   MAX(self.plotter.yLabelWidth, minYLabelWidth),
                                                                   tmpFrame.size.height - self.plotter.yPadding - self.plotter.xLabelHeight)];
        
        if (debug) [self.yLabelView setBackgroundColor:[UIColor colorWithRed:0 green:1 blue:0 alpha:0.2]];
        [self addSubview:self.yLabelView];
        
        
    }
    
    if (self.plotter.xLabelHeight != 0) {
        
        CGRect tmpFrame = self.container;
        tmpFrame.size.height -= MAX(self.plotter.xLabelHeight, minXLabelHeight);
        self.container = tmpFrame;
        
        self.xLabelView = [[UIView alloc] initWithFrame:CGRectMake(self.plotter.xPadding/2,
                                                                   tmpFrame.size.height - self.plotter.yPadding/2,
                                                                   tmpFrame.size.width - self.plotter.xPadding - self.plotter.yLabelWidth,
                                                                   MAX(self.plotter.xLabelHeight, minXLabelHeight))];
        
        if (debug) [self.xLabelView setBackgroundColor:[UIColor colorWithRed:1 green:0 blue:0 alpha:0.2]];
        [self addSubview:self.xLabelView];
    }
}
- (void)drawYLabel:(NSString *)labelText atY:(float)y inView:(UIView *)view {
    
    UILabel *tmpLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.plotter.yLabelOffset, y - self.yLabelView.frame.origin.y - 10, view.frame.size.width, 20)];
    [tmpLabel setText:labelText];
    [tmpLabel setAdjustsFontSizeToFitWidth:YES];
    [tmpLabel setTextColor:self.plotter.labelColor];
    if (debug) [tmpLabel setBackgroundColor:[UIColor colorWithRed:0 green:0 blue:1 alpha:0.3]];
    [tmpLabel setFont:[UIFont systemFontOfSize:10]];
    
    [view addSubview:tmpLabel];
}
- (void)drawXLabel:(NSString *)labelText atX:(float)x inView:(UIView *)view {
    
    UILabel *tmpLabel = [[UILabel alloc] initWithFrame:CGRectMake(x, self.plotter.xLabelOffset, 0, 20)];
    [tmpLabel setText:labelText];
    [tmpLabel setTextColor:self.plotter.labelColor];
    [tmpLabel setTextAlignment:NSTextAlignmentCenter];
    if (debug) [tmpLabel setBackgroundColor:[UIColor whiteColor]];
    [tmpLabel setFont:[UIFont systemFontOfSize:10]];
    [self setPerfectWidthForLabel:tmpLabel];
    
    [view addSubview:tmpLabel];
}

- (CGPoint)pointForX:(float)x andY:(float)y {
    
    return CGPointMake(((self.container.size.width - self.plotter.xPadding - self.plotter.pointRadius * 2) / (self.values.count - 1)) * x + self.plotter.xPadding/2 + self.plotter.pointRadius,
                       self.container.size.height - (((self.container.size.height - self.plotter.yPadding - self.plotter.pointRadius * 2) /self.plotter.yMax) * y + self.plotter.yPadding/2 + self.plotter.pointRadius));
    
}
- (void)setPerfectWidthForLabel:(UILabel *)label {
    
    CGSize maximumLabelSize = CGSizeMake(9999,label.frame.size.height);
    
    NSDictionary *attributesDictionary = [NSDictionary dictionaryWithObjectsAndKeys: label.font, NSFontAttributeName, label.textColor, NSForegroundColorAttributeName, nil];
    NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithString:label.text attributes:attributesDictionary];
    CGRect rect = [string boundingRectWithSize:maximumLabelSize options:(NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading) context:nil];
    
    [label setFrame:CGRectMake(label.frame.origin.x - rect.size.width/2 - self.plotter.xPadding/2, label.frame.origin.y, rect.size.width, label.frame.size.height)];
}

@end
