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
    NSUInteger countOps = [operations count] - 1;
    NSString * pattern = @"^(add|multiply|power|divide|subtract) \\d+\\.?\\d+?$";
    for (NSUInteger i = 0; i < countOps ; ++i) {
        NSString * line = [operations objectAtIndex:i];
        if (![self checkPattern: pattern forLine: line]) {
            return false;
        }
    }
    NSString * patternLast = @"^apply \\d+\\.?\\d+?$";
    NSString * lineLast = [operations lastObject];
    if (![self checkPattern:patternLast forLine:lineLast]) {
        return false;
    }
    return true;
}

-(BOOL) checkPattern: (NSString *) pattern forLine: (NSString *) line {
    NSRegularExpression * opRegex = [NSRegularExpression
                                     regularExpressionWithPattern:pattern
                                     options:NSRegularExpressionAnchorsMatchLines error:nil];
    if (1 == [opRegex numberOfMatchesInString:line
                                      options:NSMatchingWithoutAnchoringBounds
                                        range:NSMakeRange(0, [line length])]) {
        return true;
    } else {
        return false;
    }
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
