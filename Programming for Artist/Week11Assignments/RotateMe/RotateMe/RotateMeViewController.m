//
//  RotateMeViewController.m
//  RotateMe
//
//  Created by Dominic Amato on 4/14/13.
//  Copyright (c) 2013 Dominic Amato. All rights reserved.
//

#import "RotateMeViewController.h"

@interface RotateMeViewController ()

@property(nonatomic) BOOL autoresizesSubviews; // default is YES
@property(nonatomic) UIViewAutoresizing autoresizingMask; //default is UIViewAutoresizingNone

@end


@implementation RotateMeViewController
- (NSUInteger)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskAll;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    UIView *redView;
    UIView *blueView;
    UIView *greenView;
    UIView *purpleView;
    
    redView = [[UIView alloc] initWithFrame:CGRectMake(10, 10, 100, 100)];
    
    [redView setBackgroundColor:[UIColor redColor]];
    
    [redView setAutoresizingMask:UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleBottomMargin];
    
    [[self view] addSubview:redView];
    
    blueView = [[UIView alloc] initWithFrame:CGRectMake(self.view.frame.size.width-110, self.view.frame.size.height-110, 100, 100)];
    
    [blueView setBackgroundColor:[UIColor blueColor]];
    
    [blueView setAutoresizingMask:UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleTopMargin];
    
    [[self view] addSubview:blueView];
    
    greenView = [[UIView alloc] initWithFrame:CGRectMake(self.view.frame.size.width-110, 10, 100, 100)];
    
    [greenView setBackgroundColor:[UIColor greenColor]];
    
    [greenView setAutoresizingMask:UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleBottomMargin];
    
    [[self view] addSubview:greenView];
    
    purpleView = [[UIView alloc] initWithFrame:CGRectMake(10, self.view.frame.size.height-110, 100, 100)];
    
    [purpleView setBackgroundColor:[UIColor purpleColor]];
    
    [purpleView setAutoresizingMask:UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleTopMargin];
    
    [[self view] addSubview:purpleView];
    
    UILabel *centerLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 44)];
    
    [centerLabel setText:@"I'm in the middle"];
    
    [centerLabel setCenter:self.view.center];
    
    [centerLabel setAutoresizingMask:UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleTopMargin];
    [centerLabel sizeToFit];
    [self.view addSubview:centerLabel];
    
    UIButton *squeezeButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    
    [squeezeButton setFrame:CGRectMake(120, 10, self.view.frame.size.width-240, 44)];
    [squeezeButton setTitle:@"Squeeze Me" forState:UIControlStateNormal];
    [squeezeButton setAutoresizingMask:UIViewAutoresizingFlexibleWidth];
    [self.view addSubview:squeezeButton];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
                                duration:(NSTimeInterval)duration {
    if (UIInterfaceOrientationIsLandscape(toInterfaceOrientation)) {
        //show / hide views for landscape
    } else {
        //show / hide views for portrait
    }
}
- (void)willAnimateRotationToInterfaceOrientation:
(UIInterfaceOrientation)toInterfaceOrientation
                                         duration:(NSTimeInterval)duration {
    if (UIInterfaceOrientationIsLandscape(toInterfaceOrientation)) {
        //resize, move UI elements for landscape
    } else {
        //resize, move UI elements for portrait
    }
}

@end
