//
//  ViewController.m
//  MIPlotterDemo
//
//  Created by Mario Iannotta on 10/02/14.
//  Copyright (c) 2014 Mario Iannotta. All rights reserved.
//

#import "ViewController.h"
#import "MIPlotter.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    
    MIPlotter *plotter = [[MIPlotter alloc] initInView:self.PlotterContainer];
    
    [plotter addPlotOf:@[@0.5,@2.25,@1.39,@2.39,@1,@1.5,@2.5,@1.25,@1.9,@2.39,@2,@2,@2,@0.5,@1.85,@2.39,@1.39,@2]
              withLineColor:[UIColor colorWithRed:172/255.0 green:166/255.0 blue:16/255.0 alpha:1]
                  fillColor:[UIColor colorWithRed:226/255.0 green:220/255.0 blue:55/255.0 alpha:1]
                      andID:@"first-plot"];
    [plotter addPlotOf:@[@3.5,@5.2,@5.6,@7,@11,@11.3,@3.5,@4.2,@4.6,@4,@4.3,@3.3,@3.5,@2.6,@4,@3.4,@3.3, @3]
              withLineColor:[UIColor colorWithRed:16/255.0 green:172/255.0 blue:14/255.0 alpha:1]
                  fillColor:[UIColor colorWithRed:58/255.0 green:220/255.0 blue:77/255.0 alpha:1]
                      andID:@"second-plot"];
    
    [plotter addPlotOf:@[@5,@15,@12,@17,@14,@14,@12,@13,@12,@11,@12.4,@13,@6,@7,@8,@5,@12,@14]
              withLineColor:[UIColor colorWithRed:7/255.0 green:118/255.0 blue:179/255.0 alpha:1]
                  fillColor:[UIColor colorWithRed:126/255.0 green:187/255.0 blue:221/255.0 alpha:1]
                      andID:@"third-plot"];
    
    [plotter setLabelForXValues:@[@"1 jan", @"2 jan", @"3 jan", @"4 jan", @"5 jan", @"6 jan",@"7 jan", @"8 jan", @"9 jan", @"10 jan", @"11 jan", @"12 jan",@"13 jan", @"14 jan", @"15 jan", @"16 jan", @"17 jan", @"18 jan"]];
    [plotter setDecimationCoeff:4];
    [plotter drawAllPlotsWithYMax:20];
    //[plotter drawAllPlots];
    
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)twitter:(id)sender {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://www.twitter.com/MarioIannotta/"]];
}

- (IBAction)web:(id)sender {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://www.marioiannotta.com/"]];
}

@end
