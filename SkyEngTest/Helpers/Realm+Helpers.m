//
//  Realm+Helpers.m
//  SkyEngTest
//
//  Created by Semyon Belokovsky on 17/04/16.
//  Copyright © 2016 igrampe. All rights reserved.
//

#import "Realm+Helpers.h"
#import "SEDBObjectProtocol.h"

@implementation RLMRealm (Helpers)

- (void)deleteObjectsAndRelations:(id)array
{
    if ([array conformsToProtocol:@protocol(RLMCollection)] &&
        [array respondsToSelector:@selector(realm)])
    {
        RLMRealm *realm = nil;
        if ([array isKindOfClass:[RLMResults class]])
        {
            realm = [(RLMResults *)array realm];
        } else if ([array isKindOfClass:[RLMArray class]])
        {
            realm = [(RLMResults *)array realm];
        }
        if (realm == self)
        {
            rlm_try_begin_transaction(self)
            
            for (RLMObject *o in array)
            {
                if ([o conformsToProtocol:@protocol(SEDBObjectProtocol)])
                {
                    [(id<SEDBObjectProtocol>)o deleteRelationsInRealm:self];
                }
                [self deleteObject:o];
            }
            
            rlm_try_commit_transaction(self)
        }
    }
}

@end
