//
//  APLApiHelper.m
//  Client
//
//  Created by Semyon Belokovsky on 24/10/15.
//  Copyright © 2015 App Plus. All rights reserved.
//

#import "APLApiHelper.h"
#import "APLApiHelper+Private.h"

typedef void (^AFSuccessBlock)(AFHTTPRequestOperation *, id);
typedef void (^AFFailureBlock)(AFHTTPRequestOperation *operation, NSError *error);

NSString *const APLApiHelperApiDomain = @"APLApiHelperApiDomain";

@implementation APLApiHelper

+ (AFHTTPRequestOperation *)GET_url:(NSString *)url
                             params:(NSDictionary *)params
                       successBlock:(APLApiSuccessBlock)successBlock
                       failureBlock:(APLApiFailureBlock)failureBlock
{
    return [self GET_url:url
                  params:params
      responseSerializer:nil
            successBlock:successBlock
            failureBlock:failureBlock];
}

+ (AFHTTPRequestOperation *)GET_url:(NSString *)url
                             params:(NSDictionary *)params
                 responseSerializer:(AFHTTPResponseSerializer *)responseSerializer
                       successBlock:(APLApiSuccessBlock)successBlock
                       failureBlock:(APLApiFailureBlock)failureBlock
{
    return [self perfromHttpMethod:@"GET"
                           withUrl:url
                            params:params
                 requestSerializer:APLApiHelperSerializerJSON
                responseSerializer:responseSerializer
                      successBlock:successBlock
                      failureBlock:failureBlock];
}

#pragma mark - POST

+ (AFHTTPRequestOperation *)POST_url:(NSString *)url
          params:(NSDictionary *)params
    successBlock:(APLApiSuccessBlock)successBlock
    failureBlock:(APLApiFailureBlock)failureBlock
{
    return [self POST_url:url
                   params:params
        requestSerializer:APLApiHelperSerializerJSON
             successBlock:successBlock
             failureBlock:failureBlock];
}

+ (AFHTTPRequestOperation *)POST_url:(NSString *)url
                              params:(NSDictionary *)params
                   requestSerializer:(APLApiHelperSerializer)requestSerializer
                        successBlock:(APLApiSuccessBlock)successBlock
                        failureBlock:(APLApiFailureBlock)failureBlock
{
    return [self POST_url:url
                   params:params
        requestSerializer:requestSerializer
       responseSerializer:nil
             successBlock:successBlock
             failureBlock:failureBlock];
}

+ (AFHTTPRequestOperation *)POST_url:(NSString *)url
                              params:(NSDictionary *)params
                   requestSerializer:(APLApiHelperSerializer)requestSerializer
                  responseSerializer:(AFHTTPResponseSerializer *)responseSerializer
    successBlock:(APLApiSuccessBlock)successBlock
    failureBlock:(APLApiFailureBlock)failureBlock
{
    return [self perfromHttpMethod:@"POST"
                           withUrl:url
                            params:params
                 requestSerializer:requestSerializer
                responseSerializer:responseSerializer
                      successBlock:successBlock
                      failureBlock:failureBlock];
}

+ (AFHTTPRequestOperation *)perfromHttpMethod:(NSString *)method
                                      withUrl:(NSString *)url
                                       params:(NSDictionary *)params
                            requestSerializer:(APLApiHelperSerializer)requestSerializer
                           responseSerializer:(AFHTTPResponseSerializer *)responseSerializer
                                 successBlock:(APLApiSuccessBlock)successBlock
                                 failureBlock:(APLApiFailureBlock)failureBlock
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager new];
    AFHTTPRequestSerializer *serializer = nil;
    switch (requestSerializer)
    {
        case APLApiHelperSerializerJSON:
        {
            serializer = [AFJSONRequestSerializer serializer];
            
            break;
        }
        case APLApiHelperSerializerURLEncoded:
        {
            serializer = [AFHTTPRequestSerializer serializer];
            break;
        }
        default:
        {
            break;
        }
    }
    
    [self applyHeadersForRequestSerializer:serializer];
    
    [manager setRequestSerializer:serializer];
    
    if (responseSerializer)
    {
        [manager setResponseSerializer:responseSerializer];
    }
    
    NSDictionary *ps = params;
    AFHTTPRequestOperation *operation = nil;
    if ([method isEqualToString:@"POST"])
    {
        NSString *uri = [self addDefaultsToParamsToUrl:url];
        operation = [manager POST:uri
                       parameters:ps
                          success:[self successBlockWithSuccess:successBlock failure:failureBlock]
                          failure:[self failureBlockWithFailure:failureBlock]];
        
    } else if ([method isEqualToString:@"GET"])
    {
        ps = [self addDefaultsToParams:params];
        operation = [manager GET:url
                      parameters:ps
                         success:[self successBlockWithSuccess:successBlock
                                                       failure:failureBlock]
                         failure:[self failureBlockWithFailure:failureBlock]];
    }
    return operation;
}

+ (void)applyHeadersForRequestSerializer:(AFHTTPRequestSerializer *)serializer
{
    //
}

+ (NSDictionary *)addDefaultsToParams:(NSDictionary *)params
{
    return params;
}

+ (NSString *)addDefaultsToParamsToUrl:(NSString *)url
{
    return url;
}

+ (AFSuccessBlock)successBlockWithSuccess:(APLApiSuccessBlock)successBlock
                                  failure:(APLApiFailureBlock)failureBlock
{
    AFSuccessBlock block =
    ^void(AFHTTPRequestOperation *operation, id responseObject)
    {
        if ([responseObject isKindOfClass:[NSDictionary class]])
        {
            ALog(@"JSON: %@", responseObject);
            NSNumber *code = [responseObject objectForKey:@"error"];
            NSString *msg = [responseObject objectForKey:@"error_message"];
            if ([code integerValue])
            {
                NSMutableDictionary *userInfo = [NSMutableDictionary new];
                if (msg)
                {
                    [userInfo setObject:msg forKey:@"NSLocalizedDescription"];
                }
                NSError *error = [[NSError alloc] initWithDomain:APLApiHelperApiDomain
                                                            code:[code integerValue]
                                                        userInfo:userInfo];
                
                if (failureBlock)
                {
                    failureBlock(error);
                }
            } else
            {
                if (successBlock)
                {
                    successBlock(responseObject);
                }
            }
        }
    };
    return block;
}

+ (AFFailureBlock)failureBlockWithFailure:(APLApiFailureBlock)failureBlock
{
    AFFailureBlock block =
    ^void(AFHTTPRequestOperation *operation, NSError *error)
    {
        if (failureBlock)
        {
            failureBlock (error);
        }
    };
    return block;
}

@end
