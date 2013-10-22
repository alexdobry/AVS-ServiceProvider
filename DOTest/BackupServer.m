//
//  BackupServer.m
//  DOTest
//
//  Created by Alexander Dobrynin on 22.10.13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import "BackupServer.h"

@implementation BackupServer 

- (int) backup : (int) zahl {
    NSLog(@"Remote aufgerufen!");
    
    for(int i = 0; i < 5; i++) {
        NSLog(@".");
        [NSThread sleepForTimeInterval:1.0];
    }
    
    return zahl;
}

@end
