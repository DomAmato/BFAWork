//
//  SquareHuntViewController.m
//  SquareHunt
//
//  Created by Dominic Amato on 3/10/13.
//  Copyright (c) 2013 Dominic Amato. All rights reserved.
//

#import "SquareHuntViewController.h"

@interface SquareHuntViewController ()
@property (nonatomic,strong) NSMutableArray *touchImageViews;
@end

@implementation SquareHuntViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    int tempIndex=-1;
    _touchImageViews = [[NSMutableArray alloc] init];
    for (int i=0; i<4; i++) {
        for (int j=0; j<6;j++) {
            tempIndex++;
            UIView *temp = [[UIView alloc] initWithFrame:CGRectMake(-100+(-70*i), 40+70*j, 44, 44)];
            [temp setBackgroundColor:[UIColor redColor]];
            [self.view addSubview:temp];
            [_touchImageViews addObject:temp];
            [self updateTransformPositive:[[_touchImageViews objectAtIndex:tempIndex] transform] fromObject:temp];
        }
    }
    [NSTimer scheduledTimerWithTimeInterval:2.0
                                     target:self
                                   selector:@selector(changeColor)
                                   userInfo:nil
                                    repeats:YES];
    
   }

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void) updateTransformPositive:(CGAffineTransform) transform fromObject: (UIView*) callObject{
    transform = CGAffineTransformTranslate(transform, 1, 0);
    
    //begin the rotation from the current state:
    [UIView animateWithDuration:0.005
                          delay:0.0
                        options:UIViewAnimationOptionCurveLinear
                     animations:^{
                         [callObject setTransform:transform];
                     }
                     completion:^(BOOL finished){if(callObject.frame.origin.x>self.view.frame.size.width)[self updateTransformNegative:transform fromObject:callObject];else [self updateTransformPositive:transform fromObject:callObject];}];
}
-(void) updateTransformNegative:(CGAffineTransform) transform fromObject: (UIView*) callObject{
    transform = CGAffineTransformTranslate(transform, -1, 0);
    
    //begin the rotation from the current state:
    [UIView animateWithDuration:0.005
                          delay:0.0
                        options:UIViewAnimationOptionCurveLinear
                     animations:^{
                         [callObject setTransform:transform];
                     }
                     completion:^(BOOL finished){if(callObject.frame.origin.x<-44)[self updateTransformPositive:transform fromObject:callObject];else [self updateTransformNegative:transform fromObject:callObject];}];
}
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {    
    for (UITouch *touch in touches) {
        for (int i=0; i<[_touchImageViews count]; i++) {
            if ([[_touchImageViews objectAtIndex:i] pointInside:[touch locationInView:[_touchImageViews objectAtIndex:i]] withEvent:event]) {
                if ([[_touchImageViews objectAtIndex:i] backgroundColor]==[UIColor greenColor]) {
                    [[_touchImageViews objectAtIndex:i] removeFromSuperview];
                }
            }
        }
    }
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    for (UITouch *touch in touches) {
        for (int i=0; i<[_touchImageViews count]; i++) {
            if ([[_touchImageViews objectAtIndex:i] pointInside:[touch locationInView:[_touchImageViews objectAtIndex:i]] withEvent:event]) {
                if ([[_touchImageViews objectAtIndex:i] backgroundColor]==[UIColor greenColor]) {
                    [[_touchImageViews objectAtIndex:i] removeFromSuperview];
                }
            }
        }
    }
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {

}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event {

}
-(void) changeColor{
    for (int i=0; i<[_touchImageViews count]; i++) {
            UIView *temp =[_touchImageViews objectAtIndex:i];
        if (temp.backgroundColor==[UIColor redColor]) {
            [temp setBackgroundColor:[UIColor greenColor]];
        }
        else if (temp.backgroundColor==[UIColor greenColor])
            [temp setBackgroundColor:[UIColor redColor]];
    }
}

@end
