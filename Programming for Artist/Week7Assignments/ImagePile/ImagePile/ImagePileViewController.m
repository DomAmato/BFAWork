//
//  ImagePileViewController.m
//  ImagePile
//
//  Created by Dominic Amato on 3/10/13.
//  Copyright (c) 2013 Dominic Amato. All rights reserved.
//

#import "ImagePileViewController.h"

@interface ImagePileViewController ()
<UIGestureRecognizerDelegate>
@property (strong, nonatomic) UIImageView *imageHolder;
@property (strong, nonatomic) NSMutableArray *imgArray;

@end


@implementation ImagePileViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    _imgArray = [[NSMutableArray alloc]init];
    [self.view setBackgroundColor:[UIColor whiteColor]];

    for (int i =1; i<17; i++) {
        _imageHolder = [[UIImageView alloc] initWithImage:[UIImage imageNamed:[NSString stringWithFormat:@"image%i.png",i]]];
        [_imgArray addObject:_imageHolder];
    }
     for(UIImageView *temp in _imgArray) {
         [temp setFrame:CGRectMake(self.view.frame.size.width/4+arc4random_uniform(40), self.view.frame.size.height/5+arc4random_uniform(80), temp.frame.size.width/4.0, temp.frame.size.height/4.0)];
         [temp setContentMode:UIViewContentModeScaleAspectFit];
         [temp.layer setBorderColor: [[UIColor whiteColor] CGColor]];
         [temp.layer setBorderWidth: 15.0];
         temp.layer.shadowColor = [UIColor blackColor].CGColor;
         temp.layer.shadowOffset = CGSizeMake(0, 1);
         temp.layer.shadowOpacity = 1;
         temp.layer.shadowRadius = 10.0;
         float scale= (float)100/(85+arc4random_uniform(30));
         temp.transform = CGAffineTransformScale(temp.transform, scale, scale);
         temp.transform = CGAffineTransformRotate(temp.transform, arc4random_uniform(6));
         [self addGestures:temp];
         [self.view addSubview:temp];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)addGestures:(UIImageView *)image
{
    UIRotationGestureRecognizer *rotGesture = [[UIRotationGestureRecognizer alloc] initWithTarget:self action:@selector(rotationRecognized:)];
    
    rotGesture.delegate = self;
    UIPinchGestureRecognizer *pinchGesture = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(pinchRecognized:)];
    pinchGesture.delegate = self;
    
    UIPanGestureRecognizer *panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panRecognized:)];
    panGesture.delegate = self;
    
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapRecognized:)];
    tapGesture.delegate = self;
    
    [image addGestureRecognizer:rotGesture];
    [image addGestureRecognizer:pinchGesture];
    [image addGestureRecognizer:panGesture];
    [image addGestureRecognizer:tapGesture];
    [image setUserInteractionEnabled:YES];
}
- (void)tapRecognized:(UITapGestureRecognizer *)tapGestureRecognizer {
    for (int i=0; i<[_imgArray count]; i++) {
        if([_imgArray objectAtIndex:i]==tapGestureRecognizer.view){
            [self.view bringSubviewToFront:[_imgArray objectAtIndex:i]];
        }
    }
    
}
- (void)panRecognized:(UIPanGestureRecognizer *)panGestureRecognizer {
    
    //get the gesture recognizer's view
    if (panGestureRecognizer.state == UIGestureRecognizerStateBegan ||
        panGestureRecognizer.state == UIGestureRecognizerStateChanged) {
        //get the translation of the pan gesture
        CGPoint translation = [panGestureRecognizer translationInView:[panGestureRecognizer.view superview]];
                
        [panGestureRecognizer.view setCenter:CGPointMake(panGestureRecognizer.view.center.x + translation.x, panGestureRecognizer.view.center.y + translation.y)];
        [panGestureRecognizer setTranslation:CGPointZero inView:panGestureRecognizer.view];

        [panGestureRecognizer setTranslation:CGPointZero inView:panGestureRecognizer.view];
    }
}

- (void)pinchRecognized:(UIPinchGestureRecognizer *)pinchGestureRecognizer {
    if (pinchGestureRecognizer.state == UIGestureRecognizerStateBegan ||
        pinchGestureRecognizer.state == UIGestureRecognizerStateChanged) {
        if (pinchGestureRecognizer.scale>1.0 && pinchGestureRecognizer.view.frame.size.width<400 ||pinchGestureRecognizer.scale<1.0 && pinchGestureRecognizer.view.frame.size.width>80) {
            CGFloat scale = pinchGestureRecognizer.scale;
            [pinchGestureRecognizer.view setTransform:CGAffineTransformScale(pinchGestureRecognizer.view.transform, scale, scale)];
            [pinchGestureRecognizer setScale:1.0];
            NSLog(@"%f", pinchGestureRecognizer.view.frame.size.width);
        }
    }
}

- (void)rotationRecognized:(UIRotationGestureRecognizer *)rotationGestureRecognizer {
    if (rotationGestureRecognizer.state == UIGestureRecognizerStateBegan ||
        rotationGestureRecognizer.state == UIGestureRecognizerStateChanged) {
        CGFloat rotate = rotationGestureRecognizer.rotation;
        
        [rotationGestureRecognizer.view setTransform:CGAffineTransformRotate(rotationGestureRecognizer.view.transform, rotate)];
        [rotationGestureRecognizer setRotation:0.0];
    }
}

#pragma mark - UIGestureRecognizer Delegate Methods

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    return YES;
}
@end
