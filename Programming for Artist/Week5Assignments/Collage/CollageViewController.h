//
//  CollageViewController.h
//  Week5Assignments
//
//  Created by Dominic Amato on 2/25/13.
//  Copyright (c) 2013 University of Wisconsin Milwaukee. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CollageViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIImageView *bG;
@property (strong, nonatomic) NSMutableArray *collageImages;
@property (strong, nonatomic) UIImageView *space;
@property (weak, nonatomic) IBOutlet UISlider *alphSlid;
@property (strong, nonatomic) UIImageView *butterfly;
- (IBAction)alphaSlider:(id)sender;
@end
