//
//  SESerializableObject.m
//  SkyEngTest
//
//  Created by Semyon Belokovsky on 16/04/16.
//  Copyright © 2016 igrampe. All rights reserved.
//

#import "SESerializableObject.h"

@implementation SESerializableObject

+ (EKObjectMapping *)objectMapping
{
    return [EKObjectMapping mappingForClass:[self class]
                                  withBlock:
            ^(EKObjectMapping *mapping)
            {
            }];
}


@end
