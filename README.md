MIPlotter
=========
Draw your histograms quickly and easily.

Setup
========
+ Add the following files to your project

```
MIPlotter.h
MIPlotter.m
MISinglePlot.h
MISinglePlot.m
```
+ Import "MIPlotter.h" in your view controller
+ Do something like this

```objectivec
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

// your awesome configuration here...

[plotter drawAllPlotsWithYMax:25];
```

Configuration
=======
```objectivec

// LEGEND:  N = an integer value, R = a float value, UI_COLOR = a UIColor.

[plotter setDecimationCoeff:N]; // will show one label each N (ex: N = 4 => [1] 2 3 4 [5] 6 7 8 [9])

[plotter setBackLineColor:UI_COLOR]; // will set the color of the lines in background (the dotted ones)
[plotter setLabelColor:UI_COLOR]; // will set the color of the labels (both x and y)

[plotter setPointRadius:R]; // will set the point radius (R = 0 will not show points)
[plotter setLineWidth:R]; // will set the width for all the lines

[plotter setXPadding:R]; // will set the space between the plot and the left and right sides.
[plotter setXLabelHeight:R]; // will set the width of all x labels
[plotter setXLabelOffset:R]; // will set the space between the plot and the x labels

[plotter setYPadding:R]; // will set the space between the plot and the top and bottom sides.
[plotter setYLabelWidth:R]; // will set the width of all y labels
[plotter setYLabelOffset:R]; // will set the space between the plot and the y labels

[plotter setYNumberDivision:N]; // will set the number of the y labels displayed

[plotter drawAllPlots]; // will automatically get the max value and draw all plots added
[plotter drawAllPlotsWithYMax:R]; // will draw all plots added with the max value specified
```

Result
========
![MIPlotter](/result.png "Draw your histograms quickly and easily.")

