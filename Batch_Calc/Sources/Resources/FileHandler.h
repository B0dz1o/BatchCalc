//
//  FileHandler.h
//  Batch_Calc
//
//  Created by Piotr Bogdan on 9/7/16.
//  Copyright © 2016 Piotr Bogdan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TextResource.h"

@interface FileHandler : NSObject <TextResource>

-(instancetype) initWithFile: (NSString *) path;
@end
