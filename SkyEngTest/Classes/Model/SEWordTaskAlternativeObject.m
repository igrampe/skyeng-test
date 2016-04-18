//
//  SEWordTaskAlternativeObject.m
//  SkyEngTest
//
//  Created by Semyon Belokovsky on 17/04/16.
//  Copyright © 2016 igrampe. All rights reserved.
//

#import "SEWordTaskAlternativeObject.h"
#import "SEWordTaskAlternativePonso.h"

#import "Realm+Helpers.h"

@implementation SEWordTaskAlternativeObject

- (void)updateInRealm:(RLMRealm *)realm withPonso:(SEWordTaskAlternativePonso *)ponso
{
    rlm_try_begin_transaction(realm)
    
    self.text = ponso.text;
    self.translation = ponso.translation;
    
    rlm_try_commit_transaction(realm)
}

+ (instancetype)createInRealm:(RLMRealm *)realm withPonso:(SEWordTaskAlternativePonso *)ponso
{
    rlm_try_begin_transaction(realm)
    
    SEWordTaskAlternativeObject *object = [SEWordTaskAlternativeObject new];
    [object updateInRealm:realm withPonso:ponso];
    [realm addObject:object];
    
    rlm_try_commit_transaction(realm)
    
    return object;
}

#pragma mark - SEDBObjectProtocol

- (SEWordTaskAlternativePonso *)ponso
{
    SEWordTaskAlternativePonso *ponso = [SEWordTaskAlternativePonso new];
    
    ponso.text = self.text;
    ponso.translation = self.translation;
    
    return ponso;
}

@end
