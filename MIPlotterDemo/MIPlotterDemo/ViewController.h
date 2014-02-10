//
//  ViewController.h
//  MIPlotterDemo
//
//  Created by Mario Iannotta on 10/02/14.
//  Copyright (c) 2014 Mario Iannotta. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIView *PlotterContainer;

- (IBAction)twitter:(id)sender;
- (IBAction)web:(id)sender;

@end
