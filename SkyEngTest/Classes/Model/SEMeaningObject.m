//
//  SEMeaningObject.m
//  SkyEngTest
//
//  Created by Semyon Belokovsky on 16/04/16.
//  Copyright © 2016 igrampe. All rights reserved.
//

#import "SEMeaningObject.h"
#import "SEMeaningPonso.h"

@implementation SEMeaningObject

+ (NSString *)primaryKey
{
    return NSStringFromSelector(@selector(identifier));
}

+ (NSArray *)indexedProperties
{
    return @[NSStringFromSelector(@selector(rnd_index))];
}

#pragma mark - Public

- (void)updateInRealm:(RLMRealm *)realm withPonso:(SEMeaningPonso *)ponso
{
    BOOL needCommmit = NO;
    if (!realm.inWriteTransaction)
    {
        needCommmit = YES;
        [realm beginWriteTransaction];
    }
    
    if (self.identifier == 0)
    {
        self.identifier = ponso.identifier;
    }
    self.name = ponso.name;
    if (self.rnd_index == 0 && ponso.rnd_index != 0)
    {
        self.rnd_index = ponso.rnd_index;
    }
    
    if (needCommmit)
    {
        [realm commitWriteTransaction];
    }
}

+ (instancetype)createInRealm:(RLMRealm *)realm withPonso:(SEMeaningPonso *)ponso
{
    BOOL needCommmit = NO;
    if (!realm.inWriteTransaction)
    {
        needCommmit = YES;
        [realm beginWriteTransaction];
    }
    
    SEMeaningObject *object = [SEMeaningObject new];
    
    [object updateInRealm:realm withPonso:ponso];
    [realm addObject:object];
    
    if (needCommmit)
    {
        [realm commitWriteTransaction];
    }
    
    return object;
}

#pragma mark - SEDBObjectProtocol

- (SEMeaningPonso *)ponso
{
    SEMeaningPonso *ponso = [SEMeaningPonso new];
    ponso.identifier = self.identifier;
    ponso.name = self.name;
    ponso.rnd_index = self.rnd_index;
    
    return ponso;
}

@end
