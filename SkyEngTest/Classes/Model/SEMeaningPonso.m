//
//  SEMeaningPonso.m
//  SkyEngTest
//
//  Created by Semyon Belokovsky on 16/04/16.
//  Copyright © 2016 igrampe. All rights reserved.
//

#import "SEMeaningPonso.h"

@implementation SEMeaningPonso

+ (EKObjectMapping *)objectMapping
{
    EKObjectMapping *superMapping = [super objectMapping];
    EKObjectMapping *mapping = [EKObjectMapping mappingForClass:[self class]
                                                      withBlock:
    ^(EKObjectMapping *mapping)
    {
        [mapping mapPropertiesFromMappingObject:superMapping];
        [mapping mapPropertiesFromDictionary:@{@"id":@"identifier",
                                               @"name":@"name"}];
    }];
    return mapping;
}

@end
