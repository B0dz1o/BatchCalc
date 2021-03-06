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

- (void) testInit {
    XCTAssertNotNil([[TextParser alloc] initWithCommands:@""]);
    XCTAssertNotNil([[TextParser alloc] initWithCommands:@"add 2.04\nmultiply 1\ndivide 12.3\nsubtract -5.2\npower -12.3\napply -2"]);
}

- (void)testParsePerformance {
    NSString * comm = @"add 2.04\nmultiply 1\ndivide 12.3\nsubtract -5.2\npower -12.3\napply -2";
    TextParser * tP = [[TextParser alloc] initWithCommands:comm];
    [self measureBlock:^{
        for (int i = 0; i < 1000; ++i) {
            [tP checkBatch];
        }
    }];
}

- (void) testOpEquality {
    NSString * comm = @"add 2.04\nmultiply 25\ndivide 2\nsubtract -5.0\napply -2";
    XCTAssertEqual(5.5, [[[TextParser alloc] initWithCommands:comm] performOperations]);
    
    comm = @"subtract 2\nmultiply 3\napply 7";
    XCTAssertEqual(15, [[[TextParser alloc] initWithCommands:comm] performOperations]);
    
    comm = @"power 2\nmultiply 3.2\napply 1.0";
    XCTAssertEqual(3.2, [[[TextParser alloc] initWithCommands:comm] performOperations]);
    
    comm = @"add 2\ndivide 5\napply -1.0";
    XCTAssertEqual(0.2, [[[TextParser alloc] initWithCommands:comm] performOperations]);
    
    comm = @"multiply 3\nadd 5\napply 0";
    XCTAssertEqual(5, [[[TextParser alloc] initWithCommands:comm] performOperations]);
    
    comm = @"add 2\napply 1e5";
    XCTAssertEqual(1e5+2, [[[TextParser alloc] initWithCommands:comm] performOperations]);
}

- (void) testOpPerformance {
    [self measureBlock:^{
        for(int i = 0 ; i < 1000; ++i) {
            NSString * comm = @"add 2.04\nmultiply 1\ndivide 12.3\nsubtract -5.2\npower -12.3\napply -2";
            [[[TextParser alloc] initWithCommands:comm] performOperations];
            
            comm = @"subtract 2\napply 7";
            [[[TextParser alloc] initWithCommands:comm] performOperations];
            
            comm = @"power 2\napply 1.0";
            [[[TextParser alloc] initWithCommands:comm] performOperations];
            
            comm = @"add 2\napply -1.0";
            [[[TextParser alloc] initWithCommands:comm] performOperations];
            
            comm = @"multiply 3\nadd 5\napply 0";
            [[[TextParser alloc] initWithCommands:comm] performOperations];
            
            comm = @"add 2\napply 1e5";
            [[[TextParser alloc] initWithCommands:comm] performOperations];
        }
    }];
}

- (void) testSingleOp {
    NSString * comm = @"add 3\napply 3";
    XCTAssertEqual(6, [[[TextParser alloc] initWithCommands:comm] performOperations]);
    
    comm = @"subtract 3\napply 3";
    XCTAssertEqual(0, [[[TextParser alloc] initWithCommands:comm] performOperations]);
    
    comm = @"power 3\napply 3";
    XCTAssertEqual(27, [[[TextParser alloc] initWithCommands:comm] performOperations]);
    
    comm = @"multiply 3\napply 3";
    XCTAssertEqual(9, [[[TextParser alloc] initWithCommands:comm] performOperations]);
    
    comm = @"divide 3\napply 3";
    XCTAssertEqual(1, [[[TextParser alloc] initWithCommands:comm] performOperations]);
    
    //Only for sake of full UT coverage
    comm = @"wrongOp 3\napply 3";
    XCTAssertEqual(3, [[[TextParser alloc] initWithCommands:comm] performOperations]);
}


@end
