//
//  BackupServer.m
//  DOTest
//
//  Created by Alexander Dobrynin on 22.10.13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import "MathService.h"

@implementation MathService

-(int) isPrime:(int)number {
    NSLog(@"isPrime called");
    for (int i = 2; i < number; i++) {
        if (number % i == 0 && i != number) return 0;
    }
    return 1;
}

@end
