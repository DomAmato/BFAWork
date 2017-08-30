//
//  PoemViewController.m
//  Week4Assignment
//
//  Created by Dominic Amato on 2/18/13.
//  Copyright (c) 2013 University of Wisconsin Milwaukee. All rights reserved.
//

#import "PoemViewController.h"

@implementation PoemViewController
@synthesize eLine1;
@synthesize eLine2;
@synthesize eLine3;
@synthesize colorArray;

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    UIColor *color1 = [UIColor blackColor];
    UIColor *color2 = [UIColor blueColor];
    UIColor *color3 = [UIColor redColor];
    UIColor *color4 = [UIColor greenColor];
    UIColor *color5 = [UIColor magentaColor];
    UIColor *color6 = [UIColor cyanColor];
    colorArray = [[NSArray alloc ] initWithObjects:color1,color2,color3,color4,color5,color6,nil];
	NSMutableAttributedString * string = [[NSMutableAttributedString alloc] initWithString:@"古池や"];
    [string addAttribute:(NSString*)kCTForegroundColorAttributeName value:[colorArray objectAtIndex:0] range:NSMakeRange(0,1)];
    UILabel *line1 = [[UILabel alloc] init];
    // [line1 setText:@"古池や"];
    [line1 setText:[string string]]; 
    
    //[line1 setTextColor:[UIColor redColor]];
    [line1 sizeToFit];
    [line1 setCenter:CGPointMake(self.view.frame.size.width/2.0, 70)];
    UILabel *line2 = [[UILabel alloc] init];
    [line2 setText:@"蛙飛込む"];
    [line2 setTextColor:[colorArray objectAtIndex:1]];
    [line2 sizeToFit];
    [line2 setCenter:CGPointMake(self.view.frame.size.width/2.0, 100)];
    UILabel *line3 = [[UILabel alloc] init];
    [line3 setText:@"水の音"];
    [line3 setTextColor:[colorArray objectAtIndex:2]];
    [line3 sizeToFit];
    [line3 setCenter:CGPointMake(self.view.frame.size.width/2.0, 130)];
    [eLine1 setText:@"old pond . . ."];
    [eLine2 setText:@"a frog leaps in"];
    [eLine3 setText:@"water’s sound"];
    [eLine1 sizeToFit];
    [eLine2 sizeToFit];
    [eLine3 sizeToFit];
    [eLine1 setTextColor:[colorArray objectAtIndex:3]];
    [eLine2 setTextColor:[colorArray objectAtIndex:4]];
    [eLine3 setTextColor:[colorArray objectAtIndex:5]];
    
    [self.view addSubview:line1];
    [self.view addSubview:line2];
    [self.view addSubview:line3];
    [self.view addSubview:eLine1];
    [self.view addSubview:eLine2];
    [self.view addSubview:eLine3];
}

- (void)viewDidUnload
{
    [self setELine1:nil];
    [self setELine2:nil];
    [self setELine3:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
    } else {
        return YES;
    }
}

@end
