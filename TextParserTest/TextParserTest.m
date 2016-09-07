//
//  TextParserTest.m
//  TextParserTest
//
//  Created by Piotr Bogdan on 9/7/16.
//  Copyright © 2016 Piotr Bogdan. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "Header.h"

@interface TextParserTest : XCTestCase

@end

@implementation TextParserTest

- (void)setUp {
    [super setUp];
}

- (void)tearDown {
    [super tearDown];
}

- (void)testProtocol {
    TextParser * tP = [[TextParser alloc] initWithCommands:@""];
    BOOL conforms = [[tP class] conformsToProtocol:@protocol(ResourceParser)];
    XCTAssertTrue(conforms);
}

- (void)testRegex {
    NSString * comm = @"add 2\napply 1";
    TextParser * tP = [[TextParser alloc] initWithCommands:comm];
    XCTAssertTrue([tP checkBatch]);
    
    comm = @"apply 2\nadd 1";
    tP = [[TextParser alloc] initWithCommands:comm];
    XCTAssertFalse([tP checkBatch]);
    
    comm = @"appl 2\nadd 1";
    tP = [[TextParser alloc] initWithCommands:comm];
    XCTAssertFalse([tP checkBatch]);
    
    comm = @"add 2\napply 1-2";
    tP = [[TextParser alloc] initWithCommands:comm];
    XCTAssertFalse([tP checkBatch]);
    
    comm = @"add 2.04\nmultiply 1\ndivide 12.3\nsubtract -5.2\npower -12.3\napply -2";
    tP = [[TextParser alloc] initWithCommands:comm];
    XCTAssertTrue([tP checkBatch]);
}

- (void)testPerformance {
    NSString * comm = @"add 2.04\nmultiply 1\ndivide 12.3\nsubtract -5.2\npower -12.3\napply -2";
    TextParser * tP = [[TextParser alloc] initWithCommands:comm];
    [self measureBlock:^{
        for (int i = 0; i < 1000; ++i) {
            [tP checkBatch];
        }
    }];
}

@end
