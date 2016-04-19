//
//  SEWordTaskPonso.m
//  SkyEngTest
//
//  Created by Semyon Belokovsky on 17/04/16.
//  Copyright © 2016 igrampe. All rights reserved.
//

#import "SEWordTaskPonso.h"
#import "SEWordTaskAlternativePonso.h"
#import "NSString+Helpers.h"

@implementation SEWordTaskPonso

+ (EKObjectMapping *)objectMapping
{
    EKObjectMapping *superMapping = [super objectMapping];
    EKObjectMapping *mapping = [EKObjectMapping mappingForClass:[self class]
                                                      withBlock:
    ^(EKObjectMapping *mapping)
    {
        [mapping mapPropertiesFromMappingObject:superMapping];
        [mapping mapPropertiesFromArray:@[NSStringFromSelector(@selector(meaningId)),
                                          NSStringFromSelector(@selector(posCode)),
                                          NSStringFromSelector(@selector(text)),
                                          NSStringFromSelector(@selector(translation)),
                                          NSStringFromSelector(@selector(definition)),
                                          NSStringFromSelector(@selector(transcription))]];
        [mapping mapKeyPath:@"soundUrl"
                 toProperty:NSStringFromSelector(@selector(soundUrl))
             withValueBlock:^id(NSString *key, id value)
        {
            NSString *result = nil;
            if ([value isKindOfClass:[NSString class]])
            {
                result = [(NSString *)value fixedUrlString];
            }
            
            return result;
        }];
        
        [mapping hasMany:[SEWordTaskAlternativePonso class] forKeyPath:@"alternatives"];
        
        [mapping mapKeyPath:@"images"
                 toProperty:NSStringFromSelector(@selector(images))
             withValueBlock:^id(NSString *key, id value)
        {
            NSArray *result = nil;
            
            if ([value isKindOfClass:[NSArray class]])
            {
                NSMutableArray *mArr = [NSMutableArray new];
                NSArray *arr = (NSArray *)value;
                for (NSString *v in arr)
                {
                    if ([v isKindOfClass:[NSString class]])
                    {
                        [mArr addObject:[(NSString *)v fixedUrlString]];
                    }
                }
                result = [NSArray arrayWithArray:mArr];
            }
            
            return result;
        }];
    }];
    
    return mapping;
}

@end
