//
//  main.m
//  Batch_Calc
//
//  Created by Piotr Bogdan on 9/6/16.
//  Copyright © 2016 Piotr Bogdan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Header.h"

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        for (int i = 1; i < argc ; ++i) {
            NSString * filePath = [NSString stringWithUTF8String:argv[i]];
            id <TextResource> input = [[FileHandler alloc] initWithFile:filePath];
            NSString * commands = [input retrieveInput];
        }
    }
    return 0;
}
