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

@implementation AppDelegate

@synthesize window = _window;

- (void)dealloc
{
    [super dealloc];
}
	
- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    /*
    NSLog(@"applicationDidFinishLaunching");
    NSAutoreleasePool * pool = [[NSAutoreleasePool alloc] init];
    
    NSSocketPort *port = [[NSSocketPort alloc] init];
    NSConnection *connection = [NSConnection connectionWithReceivePort:port sendPort:port];
    BOOL isConnected = [[NSSocketPortNameServer sharedInstance] registerPort:port name:@"worker2"];
    
    MathService * mathService = [[MathService alloc] init];
    
    [connection setRootObject: mathService];
    
    if (!isConnected) {
        NSLog(@"Impossible to vend this object.");
    } else {
        NSLog(@"Object vended.");
    }
    
    [[NSRunLoop currentRunLoop] run];
    [pool drain];
     */
    
    IplImage * pInpImg = 0;
    
    // Load an image from file - change this based on your image name
    pInpImg = cvLoadImage("/Users/alexdobry/Developer/AVS-ServiceProvider/DOTest/my_image.jpg", CV_LOAD_IMAGE_UNCHANGED);
    if(!pInpImg)
    {
        fprintf(stderr, "failed to load input image\n");
    }
    
    // Write the image to a file with a different name,
    // using a different image format -- .png instead of .jpg
    if( !cvSaveImage("/Users/alexdobry/Developer/AVS-ServiceProvider/DOTest/my_image_copy.png", pInpImg, 0) )
    {
        fprintf(stderr, "failed to write image file\n");
    }
    
    // Remember to free image memory after using it!
    cvReleaseImage(&pInpImg);
}

@end
