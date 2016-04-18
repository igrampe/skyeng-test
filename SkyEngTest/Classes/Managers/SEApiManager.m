//
//  SEApiManager.m
//  SkyEngTest
//
//  Created by Semyon Belokovsky on 15/04/16.
//  Copyright © 2016 igrampe. All rights reserved.
//

#import "SEApiManager.h"

#import "Constants.h"
#import "SEApiHelper.h"
#import "SEWordTaskPonso.h"

@implementation SEApiManager

- (NSOperation *)apiGetWordTasksForMeaningIds:(NSArray *)ids
                                      handler:(SEApiManagerGetObjectsHandler)handler
{
    NSMutableDictionary *params = [NSMutableDictionary new];
    if (ids.count)
    {
        NSString *list = [ids componentsJoinedByString:@","];
        [params setObject:list forKey:@"meaningIds"];
    }
    [params setObject:@(CGRectGetWidth([UIScreen mainScreen].bounds))
               forKey:@"width"];
    
    NSOperation *operation = (NSOperation *)[SEApiHelper GET_url:API_WORD_TASKS
                                                          params:params
                                                    successBlock:
    ^(id responseObject)
    {
        if ([responseObject isKindOfClass:[NSArray class]])
        {
            NSArray *responseArray = (NSArray *)responseObject;
            NSArray *objects = [EKMapper arrayOfObjectsFromExternalRepresentation:responseArray
                                                                      withMapping:[SEWordTaskPonso objectMapping]];
            handler(objects, nil);
        } else
        {
            NSError *err = [NSError errorWithDomain:APLApiHelperApiDomain
                                               code:-1
                                           userInfo:@{@"NSLocalizedDescription": NSLS(@"Неизвестная ошибка")}];
            handler(nil, err);
        }
    } failureBlock:
    ^(NSError *error)
    {
        handler(nil, error);
    }];
    
    return operation;
}

@end
