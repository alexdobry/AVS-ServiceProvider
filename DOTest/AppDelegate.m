//
//  AppDelegate.m
//  DOTest
//
//  Created by Alexander Dobrynin on 22.10.13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import "AppDelegate.h"
#import "HoughTransformator.h"
#import "Circle.h"

#include <opencv/cv.h>
#include <opencv/highgui.h>
#include <math.h>
@implementation AppDelegate

@synthesize window = _window;

- (void)dealloc
{
    [super dealloc];
}
	
- (IplImage*)drawCircles:(NSMutableArray*) circles on:(IplImage*) img {
    for (Circle* circle in circles) {
        cvCircle(img, cvPoint(circle.x, circle.y), circle.r, CV_RGB(255,0,0), 3, 8, 0);
    }
    return img;
}

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    // ServiceUser usage, distributed object
    HoughTransformator* hough = [[HoughTransformator alloc] init];
    NSMutableArray* circles = [[NSMutableArray alloc] init];
    
    IplImage* img = NULL;
    CvCapture *capture = 0;
    capture = cvCaptureFromCAM(-1);
    if (!capture) {
        NSLog(@"Cannot initialize webcam");
    }

    cvNamedWindow("result", CV_WINDOW_AUTOSIZE);
    
    while (true) {
        img = cvQueryFrame(capture);
        if (!img) {
            NSLog(@"Failed to retrive frame");
        }
        
        circles = [hough performHoughTransformationWithIplImage:img];
        img = [self drawCircles:circles on:img];
    
        cvShowImage("result", img);
    }

}

@end
