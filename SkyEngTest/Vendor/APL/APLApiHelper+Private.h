//
//  APLApiHelper+Private.h
//  Client
//
//  Created by Semyon Belokovsky on 23/11/15.
//  Copyright © 2015 App Plus. All rights reserved.
//

#ifndef APLApiHelper_Private_h
#define APLApiHelper_Private_h

#import "APLApiHelper.h"
#import <AFNetworking.h>
#import "Constants.h"

typedef void (^AFSuccessBlock)(AFHTTPRequestOperation *, id);

@interface APLApiHelper ()

+ (void)applyHeadersForRequestSerializer:(AFHTTPRequestSerializer *)serializer;
+ (NSDictionary *)addDefaultsToParams:(NSDictionary *)params;
+ (NSString *)addDefaultsToParamsToUrl:(NSString *)url;

@end

#endif /* APLApiHelper_Private_h */
