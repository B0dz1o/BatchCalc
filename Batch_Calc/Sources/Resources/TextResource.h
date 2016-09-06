//
//  TextResource.h
//  Batch_Calc
//
//  Created by Piotr Bogdan on 9/7/16.
//  Copyright © 2016 Piotr Bogdan. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol TextResource <NSObject>

@required
- (NSString *) retrieveInput;

@end
