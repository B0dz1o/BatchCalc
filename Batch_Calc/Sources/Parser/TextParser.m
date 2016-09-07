//
//  TextParser.m
//  Batch_Calc
//
//  Created by Piotr Bogdan on 9/7/16.
//  Copyright © 2016 Piotr Bogdan. All rights reserved.
//

#import "TextParser.h"

@implementation TextParser

NSArray <NSString *> * operations;

-(instancetype) initWithCommands:(NSString *)commands {
    if (self = [super init]) {
        [self splitBatch:commands];
        return self;
    } else {
        return nil;
    }
}

-(BOOL) checkBatch {
    return true;
}

-(void) performOperations {
    
}

-(void) splitBatch: (NSString *) batch {
    operations = [batch componentsSeparatedByString:@"\n"];
    for (NSUInteger i = 0 ; i < [operations count] ; ++i) {
        NSLog(@"%@", [operations objectAtIndex:i]);
    }
}



@end
