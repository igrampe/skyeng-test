//
//  SEWordTaskAlternativePonso.m
//  SkyEngTest
//
//  Created by Semyon Belokovsky on 17/04/16.
//  Copyright © 2016 igrampe. All rights reserved.
//

#import "SEWordTaskAlternativePonso.h"

@implementation SEWordTaskAlternativePonso

+ (EKObjectMapping *)objectMapping
{
    EKObjectMapping *superMapping = [super objectMapping];
    EKObjectMapping *mapping = [EKObjectMapping mappingForClass:[self class]
                                                      withBlock:
    ^(EKObjectMapping *mapping)
    {
        [mapping mapPropertiesFromMappingObject:superMapping];
        [mapping mapPropertiesFromArray:@[NSStringFromSelector(@selector(text)),
                                          NSStringFromSelector(@selector(translation))]];
    }];
    return mapping;
}


@end
