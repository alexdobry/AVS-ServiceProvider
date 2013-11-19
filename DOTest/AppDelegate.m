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

@implementation AppDelegate

@synthesize window = _window;

- (void)dealloc
{
    [super dealloc];
}
	
- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    // ServiceUser usage
    /*HoughTransformator* hough = [[HoughTransformator alloc] init];
    NSMutableArray* circles = [hough performHoughTransformationWithImage:@"/Users/alexdobry/Developer/AVS-ServiceProvider/DOTest/Foto.jpg"];
    
    for (Circle* circle in circles) {
        NSLog(@"%@", circle);
    }*/

}

@end
