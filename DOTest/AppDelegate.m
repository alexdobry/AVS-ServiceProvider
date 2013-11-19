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
    CvFont* font;
	cvInitFont(font,CV_FONT_HERSHEY_DUPLEX,1,0.8,0.2,1,8);
    
    cvNamedWindow("result", CV_WINDOW_AUTOSIZE);
    int i = 1;
    while (true) {
        img = cvQueryFrame(capture);
        if (!img) {
            NSLog(@"Failed to retrive frame");
        }
        if ((i % 9) == 0) {
            circles = [hough performHoughTransformationWithIplImage:img];
            img = [self drawCircles:circles on:img];
        }
        cvPutText(img, [@"hallo" UTF8String], cvPoint(30,30), font, cvScalarAll(255));
        cvShowImage("result", img);
        i++;
    }

}

@end
