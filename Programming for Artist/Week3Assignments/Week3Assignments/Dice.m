//
//  Dice.m
//  Week3Assignments
//
//  Created by Dominic Amato on 2/9/13.
//  Copyright (c) 2013 University of Wisconsin Milwaukee. All rights reserved.
//

#import "Dice.h"

/*
 Goal: 
 Create a program that rolls a handful of 6-sided die. The program should use a custom NSObject to represent a dice. The object should handle the rolling operation and value storage.
 
 The Dice object should have two public properties: sides and faceValue. It should have one public method: -roll. Your implementation should make sure that values are initialized properly (you may use lazy instantiation).
 */

@implementation Dice
@synthesize faceValue,sides;

- (id)init {
    self = [super init];
    if (self) {
        self.sides = [[NSNumber alloc] initWithInt:6];
        self.faceValue = [[NSNumber alloc] initWithInt:1];
    }
    return self;
}

-(NSNumber *)roll {
    if (self.sides==nil) {
        [self setSides:[[NSNumber alloc] initWithInt:6]];
    }
    self.faceValue=[[NSNumber alloc] initWithInt:1+arc4random()%self.sides.intValue];
    return self.faceValue;
}
@end
