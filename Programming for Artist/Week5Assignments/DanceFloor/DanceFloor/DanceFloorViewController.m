//
//  DanceFloorViewController.m
//  DanceFloor
//
//  Created by Dominic Amato on 2/26/13.
//  Copyright (c) 2013 University of Wisconsin Milwaukee. All rights reserved.
//

/*Goal: 
Create a grid of custom UIButtons that covers the entire view. Change the background color of the buttons when the user interacts with them to create a colorful, customizable disco dance floor.

Extra ++:
1.	Make the buttons change other buttons' colors in addition to their own.
*/

#import "DanceFloorViewController.h"

@implementation DanceFloorViewController
@synthesize butArray;

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    [[UIApplication sharedApplication]  setStatusBarHidden:YES];
    butArray = [[NSMutableArray alloc] init];
    
    for (int j=0; j<15; j++) {
        for (int i=0; i<10; i++) {
            float width = (self.view.frame.size.width / 10.0);
            float height = (self.view.frame.size.height / 14.0);
            float originX = i * width;
            float originY = j * height;
            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
            [button addTarget:self 
                       action:@selector(buttonTouched:)
             forControlEvents:UIControlEventTouchDown];
            button.frame = CGRectMake(originX, originY, width, height);
            [button setBackgroundColor:[UIColor blackColor]];
            [self.view addSubview:button];
            [butArray addObject:button];
        }
    }
}

- (void)viewDidUnload
{
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
- (void)buttonTouched:(id)sender
{
    [sender setBackgroundColor:[UIColor colorWithRed:(float)(arc4random()%101)/100.0 green:(float)(arc4random()%101)/100.0 blue:(float)(arc4random()%101)/100.0 alpha:1.0f]];
    for (int i=0; i<[butArray count]; i++) {
        if([sender isEqual:[butArray objectAtIndex:i]]){
            if (i>10) {
                [[butArray objectAtIndex:i-10] setBackgroundColor:[UIColor colorWithRed:(float)(arc4random()%101)/100.0 green:(float)(arc4random()%101)/100.0 blue:(float)(arc4random()%101)/100.0 alpha:1.0f]];
            }
            if (i%10!=0) {
                [[butArray objectAtIndex:i-1] setBackgroundColor:[UIColor colorWithRed:(float)(arc4random()%101)/100.0 green:(float)(arc4random()%101)/100.0 blue:(float)(arc4random()%101)/100.0 alpha:1.0f]];
            }
            if (i<140) {
                [[butArray objectAtIndex:i+10] setBackgroundColor:[UIColor colorWithRed:(float)(arc4random()%101)/100.0 green:(float)(arc4random()%101)/100.0 blue:(float)(arc4random()%101)/100.0 alpha:1.0f]];
            }
            if (i%10!=9) {
                [[butArray objectAtIndex:i+1] setBackgroundColor:[UIColor colorWithRed:(float)(arc4random()%101)/100.0 green:(float)(arc4random()%101)/100.0 blue:(float)(arc4random()%101)/100.0 alpha:1.0f]];
            }
        }
    }
}

@end
