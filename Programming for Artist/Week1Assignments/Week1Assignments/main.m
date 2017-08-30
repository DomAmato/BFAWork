//
//  main.m
//  Week1Assignments
//
//  Created by Dominic Amato on 1/25/13.
//  Copyright (c) 2013 University of Wisconsin Milwaukee. All rights reserved.
//

#import <Foundation/Foundation.h>

int main (int argc, const char * argv[])
{

    @autoreleasepool {
        
        /*Goal: 
         Create a program that sums all of the multiples of 7 between 0 and 100,000.
         
         Extra ++:
         Sum all of the numbers between 0 and 100,000 that are evenly divisible by all of the following: 3, 5, and 7. Log the result.
         Find the average of the first 32 numbers in the Fibonacci series (1, 1, 2, 3, 5, 8, etc.). Log the result.
         Do the same as (2), but for the first 50 numbers in the series.*/
        
        unsigned int sumOfSeven=0;
        unsigned int sumOfAll=0;
        for (int i=0; i<100001; i++) {
            if (i%3==0 && i%5==0 && i%7==0) sumOfAll+=i;
            if (i%7==0) sumOfSeven+=i;
        }
        NSLog(@"Sevens: %u",sumOfSeven);
        NSLog(@"Sum of All: %u",sumOfAll);
        unsigned long fibSeries[50];
        double avgOf32=0;
        double avgOf50=0;
        fibSeries[0]=1;
        fibSeries[1]=1;
        for (int i=2; i<50; i++) {
            fibSeries[i]=fibSeries[i-1]+fibSeries[i-2];
        }
        for (int i=0; i<50; i++) {
            if(i<32) avgOf32+=fibSeries[i];
            avgOf50+=fibSeries[i];
        }
        NSLog(@"Average of 32 Fibonacci series: %f", avgOf32/32.0);
        NSLog(@"Average of 50 Fibonacci series: %f", avgOf50/50.0);
       
        
        
        /*Create a program that picks a single random number from 500 and checks to see if it matches certain conditions. Calculate the winnings based on the following rules (points can accumulate if multiple conditions are met):
            
            If the number is even, win 200 points. If half of the number is also even, win 250 points instead.
            If the number is higher than 100 but less than 250, win 75 points.
            If the number is less than 20 or greater than 480, win 175 points.
            If the number is none of the above, lose 100 points
         
         Extra ++:
         Here are some more rules to add to the lottery game:
         If the first two digits of the number are the same, win 99 points.
         If the last two digits of the number are the same, win 256 points.
         If the number is evenly divisible by 3, and it ends in a 9, win 300 points.*/
        
        unsigned int lottery = arc4random()%501;
        int points=0;
        if (lottery%2==0) {
            points+=200;
            if ((lottery/2)%2==0) points+=50;
        }
        if(lottery>100 && lottery<250) points+=75;
        if (lottery<20 || lottery>480) points+=175;
        if (points==0) points-=100;
        int digits[3];
        int tempVal=lottery;
        int pointer=-1;
        while (tempVal!=0) {
            digits[++pointer]= tempVal% 10;
            tempVal = tempVal / 10;
        }
        if (lottery>10){
            if (digits[0]==digits[1]) {
                points+=256;
            }
            if (lottery>100 && digits[1]==digits[2]) {
                points+=99;
            }
        }
        if (lottery%3==0 && digits[0]==9) {
            points+=300;
        }
        NSLog(@"Lottery #: %i", lottery);
        NSLog(@"Points: %i", points);
    }
    return 0;
}

