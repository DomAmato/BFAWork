//
//  ThreeButtonsViewController.m
//  ThreeButtons
//
//  Created by Dominic Amato on 2/25/13.
//  Copyright (c) 2013 University of Wisconsin Milwaukee. All rights reserved.
//


/*
 Create three UIButtons and add them to your view controller's view. You may do this in the storyboard or in code. 
 
 Extra ++:
 Make your buttons custom type (UIButtonTypeCustom) and use your own images for the normal and highlighted states.
 Make one of the buttons a 'toggle' button, where pressing it once turns something on and pressing it again turns it off. Be sure to match its display to the on / off nature of the action.
 */
 
#import "ThreeButtonsViewController.h"

@implementation ThreeButtonsViewController
@synthesize toggleButton;
@synthesize imgArray;
@synthesize toggleSwitch;

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
    imgArray = [[NSMutableArray alloc] init];

}

- (void)viewDidUnload
{
    [self setToggleButton:nil];
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

- (IBAction)leftButton:(id)sender {
    UIImageView *temp =[[UIImageView alloc] initWithFrame:CGRectMake(80, 80, 200, 150)];
    [temp setImage:[UIImage imageNamed:@"butterfly.png"]];
    [temp setContentMode:UIViewContentModeScaleAspectFit];
    [temp setClipsToBounds:YES];
    [self.view addSubview:temp];
    [imgArray addObject:temp];
}

- (IBAction)middleButton:(id)sender {
    if([imgArray count]>0)
    {
        [[imgArray objectAtIndex:[imgArray count]-1] setCenter:CGPointMake(arc4random()%(int)self.view.frame.size.width, arc4random()%(int)self.view.frame.size.height)];
        //[self.view addSubview:[imgArray objectAtIndex:[imgArray count]-1]];
    }
}

- (IBAction)rightButton:(id)sender {
    if (!toggleSwitch) {
        if ([imgArray count]>0) {
            for (int i=0; i<[imgArray count]; i++) {
                [[imgArray objectAtIndex:i] setImage:[UIImage imageNamed:@"butterflyInverted.png"]];
            }
        }
        [toggleButton setImage:[UIImage imageNamed:@"butterflyInverted.png"] forState:UIControlStateNormal];
        [toggleButton setImage:[UIImage imageNamed:@"butterfly.png"] forState:UIControlStateHighlighted];
        toggleSwitch=!toggleSwitch;
    } else {
        if ([imgArray count]>0) {
            for (int i=0; i<[imgArray count]; i++) {
                [[imgArray objectAtIndex:i] setImage:[UIImage imageNamed:@"butterfly.png"]];
            }
        }
        [toggleButton setImage:[UIImage imageNamed:@"butterfly.png"] forState:UIControlStateNormal];
        [toggleButton setImage:[UIImage imageNamed:@"butterflyInverted.png"] forState:UIControlStateHighlighted];
        toggleSwitch=!toggleSwitch;
    }
}
@end
