//
//  Realm+Helpers.h
//  SkyEngTest
//
//  Created by Semyon Belokovsky on 17/04/16.
//  Copyright © 2016 igrampe. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Realm/Realm.h>

#define rlm_try_begin_transaction(x) \
BOOL needCommmit = NO;\
if (!x.inWriteTransaction)\
{\
    needCommmit = YES; \
    [x beginWriteTransaction];\
}\

#define rlm_try_commit_transaction(x) \
if (needCommmit)\
{\
    [x commitWriteTransaction];\
}\

@interface RLMRealm (Helpers)

- (void)deleteObjectsAndRelations:(id)array;

@end
