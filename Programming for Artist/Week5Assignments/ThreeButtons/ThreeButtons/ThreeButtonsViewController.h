//
//  ThreeButtonsViewController.h
//  ThreeButtons
//
//  Created by Dominic Amato on 2/25/13.
//  Copyright (c) 2013 University of Wisconsin Milwaukee. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ThreeButtonsViewController : UIViewController
- (IBAction)leftButton:(id)sender;
- (IBAction)middleButton:(id)sender;
- (IBAction)rightButton:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *toggleButton;
@property (strong, nonatomic) NSMutableArray *imgArray;
@property (nonatomic) BOOL *toggleSwitch;

@end
