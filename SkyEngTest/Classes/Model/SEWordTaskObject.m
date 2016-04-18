//
//  SEWordTaskObject.m
//  SkyEngTest
//
//  Created by Semyon Belokovsky on 17/04/16.
//  Copyright © 2016 igrampe. All rights reserved.
//

#import "SEWordTaskObject.h"
#import "SEWordTaskPonso.h"
#import "SEWordTaskAlternativeObject.h"
#import "SEWordTaskAlternativePonso.h"

#import "Realm+Helpers.h"

@implementation SEWordTaskObject

+ (NSString *)primaryKey
{
    return NSStringFromSelector(@selector(meaningId));
}

#pragma mark - Public

- (void)updateInRealm:(RLMRealm *)realm withPonso:(SEWordTaskPonso *)ponso
{
    rlm_try_begin_transaction(realm)
    
    if (self.meaningId == 0 && ponso.meaningId != 0)
    {
        self.meaningId = ponso.meaningId;
    }
    
    self.posCode = ponso.posCode;
    self.text = ponso.text;
    self.translation = ponso.translation;
    self.definition = ponso.definition;
    self.transcription = ponso.transcription;
    self.soundUrl = ponso.soundUrl;
    
    [self.realm deleteObjects:self.images];
    for (NSString *s in ponso.images)
    {
        SEStringObject *o = [SEStringObject new];
        o.value = s;
        [realm addObject:o];
        [self.images addObject:o];
    }
    
    [self.realm deleteObjects:self.alternatives];
    for (SEWordTaskAlternativePonso *a in ponso.alternatives)
    {
        SEWordTaskAlternativeObject *o = [SEWordTaskAlternativeObject createInRealm:realm withPonso:a];
        [self.alternatives addObject:o];
    }
    
    rlm_try_commit_transaction(realm)
}

+ (instancetype)createInRealm:(RLMRealm *)realm withPonso:(SEWordTaskPonso *)ponso
{
    rlm_try_begin_transaction(realm)
    
    SEWordTaskObject *object = [SEWordTaskObject new];
    
    [object updateInRealm:realm withPonso:ponso];
    [realm addObject:object];
    
    rlm_try_commit_transaction(realm)
    
    return object;
}

#pragma mark - SEDBObjectProtocol

- (SEWordTaskPonso *)ponso
{
    SEWordTaskPonso *ponso = [SEWordTaskPonso new];
    
    ponso.meaningId = self.meaningId;
    ponso.posCode = self.posCode;
    ponso.text = self.text;
    ponso.translation = self.translation;
    ponso.definition = self.definition;
    ponso.transcription = self.transcription;
    ponso.soundUrl = self.soundUrl;
    
    NSMutableArray *arr = [NSMutableArray new];
    for (SEStringObject *o in self.images)
    {
        if (o.value)
        {
            [arr addObject:o.value];
        }
    }
    ponso.images = [NSArray arrayWithArray:arr];
    
    arr = [NSMutableArray new];
    for (SEWordTaskAlternativeObject *o in self.alternatives)
    {
        SEWordTaskAlternativePonso *p = [o ponso];
        if (p)
        {
            [arr addObject:p];
        }
    }
    ponso.alternatives = [NSArray arrayWithArray:arr];
    
    return ponso;
}

- (void)deleteRelationsInRealm:(RLMRealm *)realm
{
    rlm_try_begin_transaction(realm)
    
    [super deleteRelationsInRealm:realm];
    [self.realm deleteObjectsAndRelations:self.images];
    [self.realm deleteObjectsAndRelations:self.alternatives];
    
    rlm_try_commit_transaction(realm)
}

@end
