//
//  NSString+Helpers.m
//  SkyEngTest
//
//  Created by Semyon Belokovsky on 19/04/16.
//  Copyright © 2016 igrampe. All rights reserved.
//

#import "NSString+Helpers.h"

@implementation NSString (Helpers)

- (NSString *)fixedUrlString
{
    NSString *result = [self copy];
    if ([result hasPrefix:@"//"] && result.length > 2)
    {
        result = [@"http:" stringByAppendingString:result];
    }
    return result;
}

@end
