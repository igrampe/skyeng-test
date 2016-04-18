//
//  APLApiHelper.h
//  Client
//
//  Created by Semyon Belokovsky on 24/10/15.
//  Copyright © 2015 App Plus. All rights reserved.
//

#import <Foundation/Foundation.h>

@class AFHTTPRequestOperation;
@class AFHTTPResponseSerializer;

typedef void (^APLApiSuccessBlock)(id responseObject);
typedef void (^APLApiFailureBlock)(NSError *error);

typedef enum APLApiHelperSerializer {
    APLApiHelperSerializerJSON = 0,
    APLApiHelperSerializerURLEncoded = 1
} APLApiHelperSerializer;

extern NSString *const APLApiHelperApiDomain;

@interface APLApiHelper : NSObject

+ (AFHTTPRequestOperation *)GET_url:(NSString *)url
         params:(NSDictionary *)params
   successBlock:(APLApiSuccessBlock)successBlock
   failureBlock:(APLApiFailureBlock)failureBlock;

+ (AFHTTPRequestOperation *)GET_url:(NSString *)url
                             params:(NSDictionary *)params
                 responseSerializer:(AFHTTPResponseSerializer *)responseSerializer
                       successBlock:(APLApiSuccessBlock)successBlock
                       failureBlock:(APLApiFailureBlock)failureBlock;

+ (AFHTTPRequestOperation *)POST_url:(NSString *)url
          params:(NSDictionary *)params
    successBlock:(APLApiSuccessBlock)successBlock
    failureBlock:(APLApiFailureBlock)failureBlock;

+ (AFHTTPRequestOperation *)POST_url:(NSString *)url
          params:(NSDictionary *)params
requestSerializer:(APLApiHelperSerializer)requestSerializer
    successBlock:(APLApiSuccessBlock)successBlock
    failureBlock:(APLApiFailureBlock)failureBlock;

+ (AFHTTPRequestOperation *)POST_url:(NSString *)url
                              params:(NSDictionary *)params
                   requestSerializer:(APLApiHelperSerializer)requestSerializer
                  responseSerializer:(AFHTTPResponseSerializer *)responseSerializer
                        successBlock:(APLApiSuccessBlock)successBlock
                        failureBlock:(APLApiFailureBlock)failureBlock;

@end
