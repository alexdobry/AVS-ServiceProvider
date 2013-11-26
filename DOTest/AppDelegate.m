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
#import "CPUUsage.h"
#import "InformantProtocol.h"

#include <opencv/cv.h>
#include <opencv/highgui.h>
#include <math.h>

@implementation AppDelegate

@synthesize window = _window;

- (void)dealloc
{
    [super dealloc];
}
	
- (void)worker:(id)host{
    NSAutoreleasePool * pool = [[NSAutoreleasePool alloc] init];
    
    NSString* currentHost = [[NSHost currentHost] localizedName];
    
    NSSocketPort *port = [[NSSocketPort alloc] init];
    NSConnection *connection = [NSConnection connectionWithReceivePort:port sendPort:port];
    BOOL isConnected = [[NSSocketPortNameServer sharedInstance] registerPort:port name:currentHost];
    
    
    NSLog(@"I am %@.", currentHost);
    
    HoughTransformator * hough = [[HoughTransformator alloc] init];
    [connection setRootObject: hough];
    
    if (!isConnected) {
        NSLog(@"Impossible to vend this object.");
    } else {
        NSLog(@"Object vended.");
    }
    [[NSRunLoop currentRunLoop] run];
    
    [pool release];
}

- (void)informant:(id)host{
    NSAutoreleasePool * pool = [[NSAutoreleasePool alloc] init];
    
    NSString* currentHost = [[NSHost currentHost] localizedName];
    NSString * serviceHost = [currentHost stringByAppendingString:@"_service"];
    
    NSSocketPort *port = [[NSSocketPort alloc] init];
    NSConnection *connection = [NSConnection connectionWithReceivePort:port sendPort:port];
    BOOL isConnected = [[NSSocketPortNameServer sharedInstance] registerPort:port name:serviceHost];
    
    NSLog(@"I am %@.", serviceHost);
    
    CPUUsage * informant = [[CPUUsage alloc] init];
    [connection setRootObject: informant];
    
    
    if (!isConnected) {
        NSLog(@"Impossible to vend this object.");
    } else {
        NSLog(@"Object vended.");
    }
    [[NSRunLoop currentRunLoop] run];
    
    [pool release];
}

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    NSLog(@"applicationDidFinishLaunching");
    NSAutoreleasePool * pool = [[NSAutoreleasePool alloc] init];
    
    NSThread* worker = [[NSThread alloc] initWithTarget:self selector:@selector(worker:) object:nil];
    NSThread* informant = [[NSThread alloc] initWithTarget:self selector:@selector(informant:) object:nil];
    
    [worker start];
    [informant start];
    
    [pool drain];
}

@end
