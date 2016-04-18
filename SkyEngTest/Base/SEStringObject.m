//
//  SEStringObject.m
//  SkyEngTest
//
//  Created by Semyon Belokovsky on 17/04/16.
//  Copyright © 2016 igrampe. All rights reserved.
//

#import "SEStringObject.h"
#import "Realm+Helpers.h"

@implementation SEStringObject

- (void)updateInRealm:(RLMRealm *)realm withValue:(NSString *)value
{
    rlm_try_begin_transaction(realm)
    
    self.value = value;
    
    rlm_try_commit_transaction(realm)
}

+ (instancetype)createInRealm:(RLMRealm *)realm withValue:(NSString *)value
{
    rlm_try_begin_transaction(realm)
    
    SEStringObject *object = [SEStringObject new];
    
    [object updateInRealm:realm withValue:value];
    [realm addObject:object];
    
    rlm_try_commit_transaction(realm)
    
    return object;
}

@end
