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

@property NSArray <NSString *> * resources;

@end

@implementation FileHandlerTest

@synthesize resources;

- (void)setUp {
    [super setUp];
    [self setResources: [[NSBundle bundleForClass:[self class]] pathsForResourcesOfType:@"txt" inDirectory:@""] ];
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
    NSUInteger len = [[self resources] count];
    for (NSUInteger i = 0; i < len; ++i) {
        NSString * path = [[self resources] objectAtIndex:i];
        NSString * fileContent = [[[FileHandler alloc] initWithFile:path] retrieveInput];
        XCTAssertNotNil(fileContent);
    }
}

- (void)testBat3 {
    NSString * expected = @"multiply 2\nadd 5\ndivide 3\nsubtract 5\napply 3.0";
    NSString * batch = [[NSBundle bundleForClass:[self class]] pathForResource:@"bat3" ofType:@"txt"];
    NSString * fileContent = [[[FileHandler alloc] initWithFile:batch] retrieveInput];
    XCTAssertEqualObjects(expected, fileContent);
}

- (void)testPerformance {
    [self measureBlock:^{
        NSUInteger len = [[self resources] count];
        for (NSUInteger i = 0; i < len; ++i) {
            NSString * path = [[self resources] objectAtIndex:i];
            for (int i = 0; i < 100; ++i) {
                [[[FileHandler alloc] initWithFile:path] retrieveInput];
            }
        }
    }];
}

@end
