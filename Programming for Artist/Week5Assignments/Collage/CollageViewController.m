//
//  CollageViewController.m
//  Week5Assignments
//
//  Created by Dominic Amato on 2/25/13.
//  Copyright (c) 2013 University of Wisconsin Milwaukee. All rights reserved.
//

#import "CollageViewController.h"

@implementation CollageViewController
@synthesize bG;
@synthesize collageImages;
@synthesize space;
@synthesize alphSlid;
@synthesize butterfly;

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    [[UIApplication sharedApplication] setStatusBarHidden:YES];
    /*Goal: Create an image collage using multiple UIImageViews.
    
    Extra ++:
    Add a UISlider to your app. Make the slider crossfade two collages of images (i.e., when the slider is down, one group is showing, and when the slider is up, the other is showing).*/
    
    collageImages = [[NSMutableArray alloc] init];
    
    butterfly = [[UIImageView alloc] initWithFrame:CGRectMake(80, 80, 200, 150)];
    [butterfly setImage:[UIImage imageNamed:@"butterfly.png"]];
    [butterfly setContentMode:UIViewContentModeScaleAspectFit];
    [butterfly setClipsToBounds:YES];
    [butterfly setAlpha:0];
    
    space = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 640, 960)];
    [space setImage:[UIImage imageNamed:@"space.png"]];
    [space setContentMode:UIViewContentModeTopLeft];
    [space setClipsToBounds:YES];
    [space setAlpha:0];
    [self.view addSubview:space];
    [self.view addSubview:butterfly];
    [self.view addSubview:alphSlid];

    
    for (int i=0; i<5; i++) {
        for (int j=0; j<7; j++) {
            float width = (self.view.frame.size.width / 5.0);
            float height = (self.view.frame.size.height / 7.0);
            float originX = i * width;
            float originY = j * height;
            UIImageView *temp = [[UIImageView alloc] initWithFrame:CGRectMake(originX, originY, width, height)];
            [temp setImage:[UIImage imageNamed:@"butterfly.png"]];
            [temp setContentMode:UIViewContentModeScaleAspectFit];
            [self.view addSubview:temp];
            [collageImages addObject:temp];
        }
    }
    

}

- (void)viewDidUnload
{
    [self setBG:nil];
    [self setAlphSlid:nil];
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

- (IBAction)alphaSlider:(id)sender {
    UISlider *slider = (UISlider *)sender;
    float sliderValue = slider.value; //0.0 to 1.0
    
    bG.alpha = 1-sliderValue;
    for (int i=0; i<self.collageImages.count ; i++) {
        [[collageImages objectAtIndex:i] setAlpha:1-sliderValue];
    }    
    space.alpha = sliderValue;
    butterfly.alpha = sliderValue;
}
@end
