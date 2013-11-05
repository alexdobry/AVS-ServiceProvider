//
//  AppDelegate.m
//  DOTest
//
//  Created by Alexander Dobrynin on 22.10.13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import "AppDelegate.h"
#import "MathService.h"

@implementation AppDelegate

@synthesize window = _window;

- (void)dealloc
{
    [super dealloc];
}


	
- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    NSLog(@"applicationDidFinishLaunching");
    NSAutoreleasePool * pool = [[NSAutoreleasePool alloc] init];
    
    
    NSString * currentHost = [[NSHost currentHost] localizedName];
    NSLog(@"I am %@.", currentHost);
    
    
    NSSocketPort *port = [[NSSocketPort alloc] init];
    NSConnection *connection = [NSConnection connectionWithReceivePort:port sendPort:port];
    BOOL isConnected = [[NSSocketPortNameServer sharedInstance] registerPort:port name:currentHost];
    
    
    
    MathService * mathService = [[MathService alloc] init];
    
    [connection setRootObject: mathService];
    
    if (!isConnected) {
        NSLog(@"Impossible to vend this object.");
    } else {
        NSLog(@"Object vended.");
    }
    
    
    [[NSRunLoop currentRunLoop] run];
    [pool drain];
}

@end
