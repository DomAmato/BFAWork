//
//  PoemViewController.h
//  Week4Assignment
//
//  Created by Dominic Amato on 2/18/13.
//  Copyright (c) 2013 University of Wisconsin Milwaukee. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CoreText/CoreText.h"

@interface PoemViewController : UIViewController

@property (weak, nonatomic) IBOutlet UILabel *eLine1;
@property (weak, nonatomic) IBOutlet UILabel *eLine2;
@property (weak, nonatomic) IBOutlet UILabel *eLine3;
@property (strong, nonatomic) NSArray *colorArray;
@end
