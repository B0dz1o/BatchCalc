//
//  FileHandler.m
//  Batch_Calc
//
//  Created by Piotr Bogdan on 9/7/16.
//  Copyright © 2016 Piotr Bogdan. All rights reserved.
//

#import "FileHandler.h"

@implementation FileHandler

NSString * filePath;

- (instancetype) initWithFile:(NSString *)path {
    if (self = [super init]) {
        filePath = path;
        return self;
    } else {
        return nil;
    }
}

- (NSString *) retrieveInput {
    NSError * err;
    NSString * input = [NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:&err];
    if (input != nil) {
        return input;
    } else {
        NSLog(@"Error occured when reading file %@", filePath);
        return nil;
    }
    
}

@end
