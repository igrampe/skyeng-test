//
//  SEApiHelper.m
//  SkyEngTest
//
//  Created by Semyon Belokovsky on 15/04/16.
//  Copyright © 2016 igrampe. All rights reserved.
//

#import "SEApiHelper.h"
#import "APLApiHelper+Private.h"

@implementation SEApiHelper

+ (AFSuccessBlock)successBlockWithSuccess:(APLApiSuccessBlock)successBlock
                                  failure:(APLApiFailureBlock)failureBlock
{
    AFSuccessBlock block =
    ^void(AFHTTPRequestOperation *operation, id responseObject)
    {
        if ([responseObject isKindOfClass:[NSDictionary class]])
        {
            if (successBlock)
            {
                successBlock(responseObject);
            }
        } else if ([responseObject isKindOfClass:[NSArray class]])
        {
            if (successBlock)
            {
                successBlock(responseObject);
            }
        }
    };
    return block;
}

@end
