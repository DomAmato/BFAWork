//
//  PortfolioMasterViewController.m
//  Portfolio
//
//  Created by Dominic Amato on 5/19/13.
//  Copyright (c) 2013 Dominic Amato. All rights reserved.
//

/*
Import the view controller header and implementation files of an earlier project by dragging them into the project navigator. Be sure to add them to your target, and copy the files into the new project folder.

In the MainStoryboard.storyboard, create new view controllers, one for each earlier project you want to include. Set their class to the custom view controller name.

Create a table view controller that will list the names of the projects, and when the cells are selected, push the view controller into view.

Helpful Items:
Storyboard:
segue
push
identifier
UITableViewDataSource
tableView:numberOfRowsInSection:
tableView:cellForRowAtIndexPath:
UITableViewDelegate
tableView:didDeselectRowAtIndexPath:
NSIndexPath
row
UIViewController
prepareForSegue:sender
performSegueWithIdentifier:sender:

Extra ++:
1. Customize the table view cells. Change the font, color, size, separator, or other elements.
2. Implement device rotation handling.
*/

#import "PortfolioMasterViewController.h"
#import "ImagePileViewController.h"
#import "ClockViewController.h"
#import "DanceFloorViewController.h"

@interface PortfolioMasterViewController ()
<UITableViewDataSource, UITableViewDelegate>
@property (nonatomic,strong) NSArray *portfolioList;
@property (nonatomic,weak) IBOutlet UITableView *tableView;
@end

@implementation PortfolioMasterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    [[self navigationItem] setTitle:@"Portfolio"];
    self.portfolioList = [NSArray arrayWithObjects: @"Image Pile",
                                                    @"Clock",
                                                    @"Dance Floor",
                                                    nil];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.portfolioList count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"
                                                            forIndexPath:indexPath];
    NSString *cellTitle = [self.portfolioList objectAtIndex:[indexPath row]];
    [cell.textLabel setText:cellTitle];
    cell.textLabel.highlightedTextColor = [UIColor redColor];
    cell.textLabel.backgroundColor = [UIColor orangeColor];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *selectedCell = [tableView cellForRowAtIndexPath:indexPath];
    NSString *cellText = selectedCell.textLabel.text;
    if ([cellText isEqualToString:@"Image Pile"]) {
        [self performSegueWithIdentifier:@"imgPile" sender:selectedCell];
    }
    if ([cellText isEqualToString:@"Clock"]) {
        [self performSegueWithIdentifier:@"clock" sender:selectedCell];
    }
    if ([cellText isEqualToString:@"Dance Floor"]) {
        [self performSegueWithIdentifier:@"danceFloor" sender:selectedCell];
    }
}

@end