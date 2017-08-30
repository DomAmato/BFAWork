//
//  Tumbler.m
//  Week3Assignments
//
//  Created by Dominic Amato on 2/9/13.
//  Copyright (c) 2013 University of Wisconsin Milwaukee. All rights reserved.
//

#import "Tumbler.h"

/* Extra ++:
 Create a Tumble object, which holds a group of Dice objects. The object should be able to set the number of faces for all die, roll the tumble, report the sum of the roll, and report the minimum and maximum face values rolled.
 Create two Tumbles: one with six 6-sided die, and a second with one 36-sided dice. Figure out who will roll the higher value on average, and by how much.
 */

@implementation Tumbler
@synthesize minVal,maxVal,dice,values;

- (id)init {
    self = [super init];
    if (self) {
        self.minVal = [[NSNumber alloc] initWithInt:INT32_MAX];
        self.maxVal = [[NSNumber alloc] initWithInt:0];
        self.dice = [[NSMutableArray alloc] init];
        self.values = [[NSNumber alloc] initWithInt:0];
    }
    return self;
}

-(NSNumber *)rollDie{
    self.values = [[NSNumber alloc] initWithInt:0];
    self.minVal = [[NSNumber alloc] initWithInt:INT32_MAX];
    self.maxVal = [[NSNumber alloc] initWithInt:0];
    for (int i=0; i<self.dice.count; i++) {
        NSNumber * temp = [[self.dice objectAtIndex:i] roll];
        if ([self.minVal compare:temp]==NSOrderedDescending) {
            self.minVal = temp;
        }
        if ([self.maxVal compare:temp]==NSOrderedAscending) {
            self.maxVal = temp;
        }
        self.values = [[NSNumber alloc] initWithInt:self.values.intValue+temp.intValue];
    }
    return self.values;
}
-(void)addDice{
    Dice *temp = [[Dice alloc] init];
    [[self dice] addObject:temp];
}

-(void)addDice:(NSNumber *)sides{
    Dice * temp = [[Dice alloc] init];
    [temp setSides:sides];
    [self.dice addObject:temp];
}

@end
