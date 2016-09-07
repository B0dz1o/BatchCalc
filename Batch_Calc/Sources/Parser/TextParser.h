//
//  TextParser.h
//  Batch_Calc
//
//  Created by Piotr Bogdan on 9/7/16.
//  Copyright © 2016 Piotr Bogdan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ResourceParser.h"

@interface TextParser : NSObject <ResourceParser>

- (instancetype) initWithCommands: (NSString *) commands;

@end
