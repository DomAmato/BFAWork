//
//  DanceFloorViewController.h
//  DanceFloor
//
//  Created by Dominic Amato on 2/26/13.
//  Copyright (c) 2013 University of Wisconsin Milwaukee. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DanceFloorViewController : UIViewController
- (void)buttonTouched: (id)sender;
@property (strong, nonatomic) NSMutableArray *butArray;
@end
