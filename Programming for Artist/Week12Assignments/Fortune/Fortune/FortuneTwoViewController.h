//
//  FortuneTwoViewController.h
//  Fortune
//
//  Created by Dominic Amato on 5/1/13.
//  Copyright (c) 2013 University of Wisconsin Milwaukee. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FortuneTwoViewController : UITableViewController <UITableViewDelegate,
UITableViewDataSource>
- (void)setFortuneLevel:(id)prevFortune;

@end
