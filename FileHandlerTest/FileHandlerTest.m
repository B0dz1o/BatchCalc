//
//  FileHandlerTest.m
//  FileHandlerTest
//
//  Created by Piotr Bogdan on 9/7/16.
//  Copyright © 2016 Piotr Bogdan. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "Header.h"

@interface FileHandlerTest : XCTestCase

@end

@implementation FileHandlerTest

- (void)setUp {
    [super setUp];
}

- (void)tearDown {
    [super tearDown];
}

- (void)testProtocol {
    FileHandler * fH = [[FileHandler alloc] initWithFile:@""];
    BOOL conforms = [[fH class] conformsToProtocol:@protocol(TextResource)];
    XCTAssertTrue(conforms);
}

- (void)testOpenNil {
    FileHandler * fH = [[FileHandler alloc] initWithFile:@""];
    XCTAssertNil([fH retrieveInput]);
}

- (void)testOpenTwice {
    NSString * batch = [[NSBundle bundleForClass:[self class]] pathForResource:@"bat1" ofType:@"txt"];
    NSString * first = [[[FileHandler alloc] initWithFile:batch] retrieveInput];
    NSString * second = [[[FileHandler alloc] initWithFile:batch] retrieveInput];
    XCTAssertEqualObjects(first, second);
    XCTAssertNotNil(first);
}

- (void)testOpenAll {
    for (int i = 1; i <=3; ++i) {
        NSString * path = [NSString stringWithFormat:@"bat%d", i];
        NSString * resource = [[NSBundle bundleForClass:[self class]] pathForResource:path ofType:@"txt"];
        NSString * fileContent = [[[FileHandler alloc] initWithFile:resource] retrieveInput];
        XCTAssertNotNil(fileContent);
    }
}

- (void)testMain {
}

- (void)testPerformance {
    [self measureBlock:^{
        NSString * batch = [[NSBundle bundleForClass:[self class]] pathForResource:@"bat1" ofType:@"txt"];
        for (int i = 0; i < 1000; ++i) {
            [[[FileHandler alloc] initWithFile:batch] retrieveInput];
        }
    }];
}

@end
