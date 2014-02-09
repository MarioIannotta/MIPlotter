MIPlotter
=========

![MIPlotter](/demo/banner.png "Draw your histograms quickly and easily.")
Draw your histograms quickly and easily.

Setup
========
+ Add MIPlotter folder to your project
+ Import "MIPlotter.h"
+ Do something like this

```objectivec
self.plotter = [[MIPlotter alloc] initInView:self.background];
          
[self.plotter addPlotOf:@[@0.5,@2.25,@1.39,@2.39,@1]
          withLineColor:[UIColor colorWithRed:172/255.0 green:166/255.0 blue:16/255.0 alpha:1]
              fillColor:[UIColor colorWithRed:226/255.0 green:220/255.0 blue:55/255.0 alpha:1]
                  andID:@"first-plot"];
                    
[self.plotter addPlotOf:@[@3.5,@5.2,@5.6,@7,@11,@11.3,@6,@4,@5,@4,@4.5,@3.9]
          withLineColor:[UIColor colorWithRed:16/255.0 green:172/255.0 blue:14/255.0 alpha:1]
              fillColor:[UIColor colorWithRed:58/255.0 green:220/255.0 blue:77/255.0 alpha:1]
                  andID:@"second-plot"];
              
[self.plotter addPlotOf:@[@5,@15,@12,@17,@14,@14,@19]
          withLineColor:[UIColor colorWithRed:7/255.0 green:118/255.0 blue:179/255.0 alpha:1]
              fillColor:[UIColor colorWithRed:126/255.0 green:187/255.0 blue:221/255.0 alpha:1]
                  andID:@"third-plot"];
              
              
[self.plotter drawAllPlots];
```
+ Be amazed of how easy it was

