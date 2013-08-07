//
//  xxiivvViewController.m
//  nijuniju
//
//  Created by Devine Lu Linvega on 2013-08-06.
//  Copyright (c) 2013 XXIIVV. All rights reserved.
//

#import "xxiivvViewController.h"
#import <QuartzCore/QuartzCore.h>
#import <CoreImage/CoreImage.h>
#import "xxiivvTemplates.h"

@interface xxiivvViewController ()

@end

@implementation xxiivvViewController

- (void)viewDidLoad { [super viewDidLoad]; [self start];}
- (void)didReceiveMemoryWarning{ [super didReceiveMemoryWarning]; }

- (void) start
{
	[self templateStart];
	[self gamePrepare];
	//[self performSelectorInBackground:@selector(captureBlur) withObject:nil];
}


- (void) gamePrepare
{
	self.blurTarget.hidden = YES;
	self.view.backgroundColor = [UIColor redColor];
	[NSTimer scheduledTimerWithTimeInterval:(1) target:self selector:@selector(gameReady) userInfo:nil repeats:NO];
	self.interfaceMenuTimeRemainingLabel.text = @"Preparing..";
	[self templateHintsAnimation];
}

- (void) gameReady
{
	
	self.interfaceMenuNext.alpha = 1;
	self.interfaceMenuNext.alpha = 1;
	
//	[self templateButtons];
//	[NSTimer scheduledTimerWithTimeInterval:(1) target:self selector:@selector(gameStart) userInfo:nil repeats:NO];
	self.interfaceMenuTimeRemainingLabel.text = @"Ready";
//	[self templateButtonsAnimation];
}

- (void) gameStart
{
	
	[self templateButtons];
	[self templateButtonsAnimationShow];
	
	[UIView beginAnimations: @"Slide In" context:nil];
	[UIView setAnimationDuration:3];
	[UIView setAnimationCurve:UIViewAnimationCurveLinear];
	self.interfaceMenuTimeRemaining.frame = CGRectMake(screenMargin+5, 320+4, 10, 8);
	[UIView commitAnimations];
	
	
	// move label up
	CGRect origin = self.interfaceMenuTimeRemainingLabel.frame;
	[UIView beginAnimations: @"Slide In" context:nil];
	[UIView setAnimationDuration:0.5];
	[UIView setAnimationCurve:UIViewAnimationCurveLinear];
	self.interfaceMenuNext.alpha = 0;
	self.interfaceMenuTimeRemainingLabel.frame = CGRectOffset(origin, 0, -20);
	[UIView commitAnimations];
	
	
	
	
	self.interfaceMenuTimeRemainingLabel.text = @"3 Seconds Left";
	
	[NSTimer scheduledTimerWithTimeInterval:(1) target:self selector:@selector(gameCountdown2) userInfo:nil repeats:NO];
	[NSTimer scheduledTimerWithTimeInterval:(2) target:self selector:@selector(gameCountdown1) userInfo:nil repeats:NO];
	[NSTimer scheduledTimerWithTimeInterval:(3) target:self selector:@selector(gameFinish) userInfo:nil repeats:NO];
	
}

- (void) gameCountdown2
{
	self.interfaceMenuTimeRemainingLabel.text = @"2 Seconds Left";
}

- (void) gameCountdown1
{
	self.interfaceMenuTimeRemainingLabel.text = @"1 Seconds Left";
}

- (void) gameFinish
{
	
	
	
	// move label up
	CGRect origin = self.interfaceMenuTimeRemainingLabel.frame;
	[UIView beginAnimations: @"Slide In" context:nil];
	[UIView setAnimationDuration:0.5];
	[UIView setAnimationCurve:UIViewAnimationCurveLinear];
	self.interfaceMenuNext.alpha = 0;
	self.interfaceMenuTimeRemainingLabel.frame = CGRectOffset(origin, 0, 20);
	[UIView commitAnimations];
	
	
	[self templateButtonsAnimationHide];
	
	self.interfaceMenuTimeRemainingLabel.text = @"Finished";
	[self gamePrepare];
	NSLog(@"Finished");
}


- (void) captureBlur {
    UIGraphicsBeginImageContext(self.view.bounds.size);
    [self.blurTarget.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *viewImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    CIImage *imageToBlur = [CIImage imageWithCGImage:viewImage.CGImage];
    CIFilter *gaussianBlurFilter = [CIFilter filterWithName: @"CIGaussianBlur"];
    [gaussianBlurFilter setValue:imageToBlur forKey: @"inputImage"];
    [gaussianBlurFilter setValue:[NSNumber numberWithFloat:10] forKey: @"inputRadius"];
    CIImage *resultImage = [gaussianBlurFilter valueForKey: @"outputImage"];
    
    blurrredImage = [[UIImage alloc] initWithCIImage:resultImage];
    
    UIImageView *newView = [[UIImageView alloc] initWithFrame:self.view.bounds];
    newView.image = blurrredImage;
	newView.backgroundColor = [UIColor whiteColor];
	newView.frame = CGRectMake(-30, -20, screen.size.width+60, screen.size.height+60);
    
    [self.blurContainerView insertSubview:newView belowSubview:self.transparentView];
}


- (void) option0
{
	NSLog(@"!!1");
}
- (void) option1
{
	NSLog(@"!!2");
}
- (void) option2
{
	NSLog(@"!!3");
}






- (IBAction)interfaceMenuNext:(id)sender {
	[self gameStart];
}



@end
