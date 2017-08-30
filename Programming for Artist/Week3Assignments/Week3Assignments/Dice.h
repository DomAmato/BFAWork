//
//  Dice.h
//  Week3Assignments
//
//  Created by Dominic Amato on 2/9/13.
//  Copyright (c) 2013 University of Wisconsin Milwaukee. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Dice : NSObject

@property (strong) NSNumber *faceValue;
@property (strong) NSNumber *sides;

-(NSNumber *)roll;

@end
