//
//  main.m
//  Week2Assignments
//
//  Created by Dominic Amato on 2/2/13.
//  Copyright (c) 2013 University of Wisconsin Milwaukee. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString(StringUtilities)
- (NSString *) scrambleLetters: (NSString *) S;
@end

@implementation NSString(StringUtilities)
- (NSString *) scrambleLetters: (NSString *) S
{
    NSArray *tempWords = [S componentsSeparatedByString:@" "];
    NSMutableArray *passageWords = [[NSMutableArray alloc] initWithArray:tempWords];
    NSMutableArray *scramblerArray = [[NSMutableArray alloc] init];
    NSString *tempWord = [[NSString alloc] init];
    for (int i=0; i<[passageWords count] ; i++) {
        for (int j=0; j<[[passageWords objectAtIndex:i]length]; j++) {
            [scramblerArray addObject:[[NSString alloc] initWithFormat:@"%c", [[passageWords objectAtIndex:i] characterAtIndex:j]]];
        }
        if ([scramblerArray count]>3) {
            tempWord = [tempWord stringByAppendingString:[scramblerArray objectAtIndex:0]];
            [scramblerArray removeObjectAtIndex:0];
            NSString *suffixHolder = [[NSString alloc] init];
            if ([[passageWords objectAtIndex:i]hasSuffix:@";"] || [[passageWords objectAtIndex:i]hasSuffix:@":"] || [[passageWords objectAtIndex:i]hasSuffix:@","] || [[passageWords objectAtIndex:i]hasSuffix:@"."] || [[passageWords objectAtIndex:i]hasSuffix:@"?"] || [[passageWords objectAtIndex:i]hasSuffix:@"!"]) {
                suffixHolder = [suffixHolder stringByAppendingString:[scramblerArray objectAtIndex:[scramblerArray count]-2]];
                suffixHolder = [suffixHolder stringByAppendingString:[scramblerArray objectAtIndex:[scramblerArray count]-1]];
                [scramblerArray removeObjectAtIndex:[scramblerArray count]-1];
                [scramblerArray removeObjectAtIndex:[scramblerArray count]-1];
                
            } else {
                suffixHolder = [suffixHolder stringByAppendingString:[scramblerArray objectAtIndex:[scramblerArray count]-1]];
                [scramblerArray removeObjectAtIndex:[scramblerArray count]-1];
                
            }
            while ([scramblerArray count]>0) {
                int j=arc4random()%[scramblerArray count];
                tempWord = [tempWord stringByAppendingString:[scramblerArray objectAtIndex:j]];
                [scramblerArray removeObjectAtIndex:j];
            }
            tempWord = [tempWord stringByAppendingString:suffixHolder];
            [passageWords removeObjectAtIndex:i];
            [passageWords insertObject:tempWord atIndex:i];
            tempWord = @"";
        }
        
        [scramblerArray removeAllObjects];
        
    }
    NSString *scrambledPassage = [[NSString alloc] init];
    for (int i=0; i<[passageWords count]; i++) {
        scrambledPassage = [scrambledPassage stringByAppendingString:[passageWords objectAtIndex:i]];
        scrambledPassage  = [scrambledPassage stringByAppendingString:@" "];
    }
    return scrambledPassage;
}

@end


int main (int argc, const char * argv[])
{

    @autoreleasepool {
        
        /*Goal: 
         Create a program that shuffles a deck of 52 cards and prints the order.
         
         Extra ++:
         Format the output into a single NSLog, using line breaks and indentation. Doesn't NSLog do this already? 
         Instead of printing the shuffled deck, deal a hand of five cards. Print the hand to the Console.
         Check to see if the hand in (2) is a flush. Print a message to the console with the result.
         Set up a loop that re-shuffles and deals the hand until (3) reports a successful flush. Log the number of shuffles it took to do so.*/
        int deckArray[52];
        NSMutableArray *deckCreator = [NSMutableArray array];
        int index=-1;
        for(int j=0;j<4;j++){
            for (int i=2; i<15; i++) {
                deckArray[++index]=i;
            }
        }
        for (int i=0; i<52; i++) {
            if (deckArray[i]<11) {
                [deckCreator addObject:[NSString stringWithFormat:@"%i",deckArray[i]]];
            } else if (deckArray[i]==11) {
                [deckCreator addObject:@"J"];
            } else if (deckArray[i]==12) {
                [deckCreator addObject:@"Q"];            
            } else if (deckArray[i]==13) {
                [deckCreator addObject:@"K"];
            } else if (deckArray[i]==14) {
                [deckCreator addObject:@"A"];
            }
        }
        for (int i=0; i<52; i++) {
            if (i/13==0) {
                [deckCreator addObject:[NSString stringWithFormat:@"%@H", [deckCreator objectAtIndex:0]]];
            } else if (i/13==1) {
                [deckCreator addObject:[NSString stringWithFormat:@"%@C", [deckCreator objectAtIndex:0]]];
            } else if (i/13==2) {
                [deckCreator addObject:[NSString stringWithFormat:@"%@D", [deckCreator objectAtIndex:0]]];
            } else if (i/13==3) {
                [deckCreator addObject:[NSString stringWithFormat:@"%@S", [deckCreator objectAtIndex:0]]];
            }
            [deckCreator removeObjectAtIndex:0];
        }
        NSArray *fullDeck = [[NSArray alloc] initWithArray:deckCreator];
        NSMutableArray *tempDeck = [NSMutableArray array];
        while ([deckCreator count]>0) {
            int i = arc4random()%[deckCreator count]; 
            [tempDeck addObject:[deckCreator objectAtIndex:i]];
            [deckCreator removeObjectAtIndex:i];
        }
        NSArray *shuffledDeck = [[NSArray alloc] initWithArray:tempDeck];

        NSLog(@"unshuffled deck: %@", fullDeck);
        NSLog(@"shuffled deck: %@", shuffledDeck);
        
        NSMutableArray *hand = [NSMutableArray array];
        for (int i=0; i<5; i++) {
            [hand addObject:[shuffledDeck objectAtIndex:i]];
        }
        
        NSLog(@"hand: %@",hand);
        BOOL isFlush=YES;
        for (int i=0; i<4; i++) {
            if(![[hand objectAtIndex:i] hasSuffix:[[NSString alloc] initWithFormat:@"%c", [[hand objectAtIndex:i+1]characterAtIndex:[[hand objectAtIndex:i+1]length]-1]]]){
                isFlush=NO;
                i=10;
            }
        }
        if (isFlush) {
            NSLog(@"Your Hand is a flush");
        } else { NSLog(@"Your Hand is not a flush");}
        
        int shuffles=0;
        
        while(!isFlush){
            deckCreator = [[NSMutableArray alloc] initWithArray:shuffledDeck];
            [tempDeck removeAllObjects];
            while ([deckCreator count]>0) {
                int i = arc4random()%[deckCreator count]; 
                [tempDeck addObject:[deckCreator objectAtIndex:i]];
                [deckCreator removeObjectAtIndex:i];
            }
            shuffledDeck = [[NSArray alloc] initWithArray:tempDeck];
            
            hand = [NSMutableArray array];
            for (int i=0; i<5; i++) {
                [hand addObject:[shuffledDeck objectAtIndex:i]];
            }
            isFlush=YES;
            for (int i=0; i<4; i++) {
                if(![[hand objectAtIndex:i] hasSuffix:[[NSString alloc] initWithFormat:@"%c", [[hand objectAtIndex:i+1]characterAtIndex:[[hand objectAtIndex:i+1]length]-1]]]){
                    isFlush=NO;
                    i=10;
                }
            }
            shuffles++;
        }
        NSLog(@"Flush Hand: %@", hand);
        NSLog(@"Number of Shuffles: %i", shuffles);
        
        
        
        
        /*Goal: 
         An email circulated that read:
         
         Aoccdrnig to a rscheearch at Cmabrigde Uinervtisy, it deosn't mttaer in waht oredr the ltteers in a wrod are, the olny iprmoetnt tihng is taht the frist and lsat ltteer be at the rghit pclae. The rset can be a toatl mses and you can sitll raed it wouthit porbelm. Tihs is bcuseae the huamn mnid deos not raed ervey lteter by istlef, but the wrod as a wlohe.
         
         While there was no study conducted at Cambridge University (http://www.mrc-cbu.cam.ac.uk/people/matt.davis/Cmabrigde/), the principle is fun: jumbled words can still be read. 
         
         Your task is to take a paragraph of text of your choosing and shuffle the characters of each word (except for the first and last character). Output the scrambled paragraph with an NSLog.
         
         Extra ++:
         Instead of creating a Scrambler object, implement the scrambling method as a Category on NSString. Read about Categories.*/
        
        NSString *passage = [[NSString alloc] init];
        passage = @"Certain faculties of men are directed towards the Unknown; thought, meditation, prayer. The Unknown is an ocean. What is conscience? It is the compass of the Unknown. Thought, meditation, prayer, these are the great mysterious pointings of the needle. Let us respect them. Whither tend these majestic irradiations of the soul? into shadow, that is, towards the light. \n\n To proffer thought to the thirst of men, to give to all, as an elixir, the idea of God, to cause conscience and science to fraternise in them, and to make them good men by this mysterious confrontation -- such is the province of true philosophy. Morality is truth in full bloom. Contemplation leads to action. The absolute should be practical. The ideal must be made air and food and drink to the human mind. \n\n James Joyce - The Portrait of the Artist as a Young Man \n ";
        NSLog(@"%@", passage);
        NSString *finalPassage = [[NSString alloc] init];
        finalPassage = [finalPassage scrambleLetters:passage];
        NSLog(@"%@", finalPassage);
    }
    return 0;
}

