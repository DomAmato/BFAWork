//
//  FortuneDetailViewController.m
//  Fortune
//
//  Created by Dominic Amato on 5/19/13.
//  Copyright (c) 2013 Dominic Amato. All rights reserved.
//

#import "FortuneDetailViewController.h"

@interface FortuneDetailViewController ()
@property (nonatomic, strong) NSNumber *fortune;
@property (weak, nonatomic) IBOutlet UILabel *yourFortune;

@end

@implementation FortuneDetailViewController

#pragma mark - Managing the detail item

- (void)setFortuneLevel:(id)prevFortune
{
    self.fortune = prevFortune;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    if (self.fortune.intValue == 0) {
        self.yourFortune.text = @"Things aren't looking so good for you";
    }
    if (self.fortune.intValue == 1) {
        self.yourFortune.text = @"I would tread carefully";
    }
    if (self.fortune.intValue == 2) {
        self.yourFortune.text = @"Your day should go well";
    }
    if (self.fortune.intValue == 3) {
        self.yourFortune.text = @"Todays going to be a lucky day";
    }
}
@end
