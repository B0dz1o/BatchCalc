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
    NSString * pattern = @"^(add|multiply|power|divide|subtract) -?\\d+(\\.)?\\d*$";
    for (NSUInteger i = 0; i < countOps ; ++i) {
        NSString * line = [operations objectAtIndex:i];
        if (![self checkPattern: pattern forLine: line]) {
            NSLog(@"Problem processing line:\n\t%@",line);
            return false;
        }
    }
    NSString * patternLast = @"^apply -?\\d+(\\.)?\\d*$";
    NSString * lineLast = [operations lastObject];
    if (![self checkPattern:patternLast forLine:lineLast]) {
        NSLog(@"Problem processing line:\n\t%@",lineLast);
        return false;
    }
    return true;
}

-(BOOL) checkPattern: (NSString *) pattern forLine: (NSString *) line {
    NSRegularExpression * opRegex = [NSRegularExpression
                                     regularExpressionWithPattern:pattern
                                     options:NSRegularExpressionAnchorsMatchLines error:nil];
    NSUInteger i =[opRegex numberOfMatchesInString:line
                                           options:NSMatchingWithoutAnchoringBounds
                                             range:NSMakeRange(0, [line length])];
    if (1 == i) {
        return true;
    } else {
        return false;
    }
}

-(double) performOperations {
    double result;
    NSString * lineLast = [operations lastObject];
    NSScanner * nss = [NSScanner scannerWithString:lineLast];
    [nss scanUpToString:@" " intoString:nil];
    [nss scanDouble:&result];
    NSUInteger countOps = [operations count] - 1;
    for (NSUInteger i = 0; i < countOps; ++i) {
        double operand;
        NSString * opCode;
        nss = [NSScanner scannerWithString:[operations objectAtIndex:i]];
        [nss scanUpToString:@" " intoString:&opCode];
        [nss scanDouble: &operand];
        result = [self singleOp:opCode value:result operand:operand];
    }
    return result;
}

-(double) singleOp: (NSString *) opCode value: (double) value operand: (double) operand {
    return value;
}

-(void) splitBatch: (NSString *) batch {
    operations = [batch componentsSeparatedByString:@"\n"];
}



@end
