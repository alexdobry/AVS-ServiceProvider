//
//  AppDelegate.m
//  DOTest
//
//  Created by Alexander Dobrynin on 22.10.13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import "AppDelegate.h"
#import "MathService.h"

#include <opencv/cv.h>
#include <opencv/highgui.h>
#include <math.h>

@implementation AppDelegate

@synthesize window = _window;

- (void)dealloc
{
    [super dealloc];
}
	
- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{    
    NSDate *methodStart = [NSDate date];

    // Load Image from local storage
    IplImage *src = cvLoadImage("/Users/alexdobry/Developer/AVS-ServiceProvider/DOTest/Foto.jpg", CV_LOAD_IMAGE_UNCHANGED);
    // output image (dst) of the same size and depth as src.
    IplImage *dst = cvCreateImage(cvSize(src->width, src->height), src->depth, 0);
    
    // Converts an image from one color space to another (gray).
    cvCvtColor(src, dst, CV_BGR2GRAY);
    
    // Write the image to a file with a different name
    //cvSaveImage("/Users/alexdobry/Desktop/Foto2.png", dst, 0);
    
    // using cvSmooth instead of GaussianBlur to smooth the image, otherwise a lot of false circles may be detected
    // src, dst, smoothType, density width, density height, sigma 1, sigma 2
    cvSmooth(dst, dst, CV_GAUSSIAN, 11, 11, 0, 0);
    
    // Write the image to a file with a different name
    //cvSaveImage("/Users/alexdobry/Desktop/Foto3.png", dst, 0);
    
    CvMemStorage* storage = cvCreateMemStorage(0);
    // Finds circles in a grayscale image using the Hough transform.
    // src, storage that will contain the output sequence of found circles, detection method, example code, example code, example code, example code, min, max      mindist dst->height/4
    CvSeq* result = cvHoughCircles(dst, storage, CV_HOUGH_GRADIENT, 2,100, 200, 100, 30, 120);
    
    NSLog(@"total: %d", result->total);
    
    for (int i = 0; i < result->total; i++) {
        // returns a pointer (float array) to a sequence element according to its index.
        // x = [0], y = [1], r = [2]
        float *detectedCircle = (float*) cvGetSeqElem(result, i);
        //NSLog(@"x = %f, y = %f, r = %f", detectedCircle[0], detectedCircle[1], detectedCircle[2]);
        
        // Draws a circle
        // src, center (combination of x and y), radius, color (red), thickness, example code, example code
        cvCircle(src, cvPoint(cvRound(detectedCircle[0]),cvRound(detectedCircle[1])), cvRound(detectedCircle[2]), CV_RGB(255,0,0), 3, 8, 0);
    }
    
    cvSaveImage("/Users/alexdobry/Desktop/Foto.png", src, 0);
    
    // Remember to free image memory after using it!
    cvReleaseMemStorage(&storage);
    cvReleaseImage(&dst);
    cvReleaseImage(&src);
    
    NSDate *methodFinish = [NSDate date];
    NSTimeInterval executionTime = [methodFinish timeIntervalSinceDate:methodStart];
    NSLog(@"executionTime = %f", executionTime * 1000);
    
    //Einflussfaktoren auf die Anzahl der Ergebnisse der Hough Transformation
    //Funktion cvHoguhcircles  
    //  -> min/max radius --> Spanne, welche Größe die Kreise haben dürfen 
    //  -> mindist --> Spanne zwischen den Kreismittelpunkten 
    //Bei münzen mindist = 100 und min 30 und max 120 relativ gutes ergebnis
}

@end
