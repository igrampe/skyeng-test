//
//  SEDataManager.m
//  SkyEngTest
//
//  Created by Semyon Belokovsky on 15/04/16.
//  Copyright © 2016 igrampe. All rights reserved.
//

#import "SEDataManager.h"

#import "SEMeaningObject.h"
#import "SEMeaningPonso.h"
#import "SEWordTaskObject.h"
#import "SEWordTaskPonso.h"

#import "Realm+Helpers.h"

NSString *const SEDataManagerDBName = @"words";
const NSInteger SEDataManagerDBSchemeVersion = 1;

@interface SEDataManager ()

@property (nonatomic, strong) RLMRealm *realm;

@end

@implementation SEDataManager

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        self.realm = [self createRealm];
        [self loadPredefinedData];
    }
    return self;
}

#pragma mark - Realm

- (NSString *)realmPath
{
    NSString *path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
    path = [path stringByAppendingPathComponent:@"db"];
    path = [path stringByAppendingFormat:@"_%@.realm", SEDataManagerDBName];
    return path;
}

- (RLMRealm *)createRealm
{
    RLMRealmConfiguration *config = [[RLMRealmConfiguration defaultConfiguration] copy];
    
    config.path = [self realmPath];
    config.schemaVersion = SEDataManagerDBSchemeVersion;
    config.migrationBlock =
    ^(RLMMigration *migration, uint64_t oldSchemaVersion)
    {
        // Migration block
    };
    
    NSError *error = nil;
    RLMRealm *realm = [RLMRealm realmWithConfiguration:config error:&error];
    
    NSAssert(error == nil, error.localizedDescription);
    
    return realm;
}

#pragma mark - Predefined Data

- (void)loadPredefinedData
{
    NSString *path = [[NSBundle mainBundle] pathForResource:@"default_dictionary" ofType:@"json"];
    NSData *data = [[NSData alloc] initWithContentsOfFile:path options:0 error:nil];
    if (data)
    {
        NSObject *object = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        if ([object isKindOfClass:[NSArray class]])
        {
            NSArray *dataArray = (NSArray *)object;
            NSArray *objectsArr = [EKMapper arrayOfObjectsFromExternalRepresentation:dataArray
                                                                         withMapping:[SEMeaningPonso objectMapping]];
            [self createOrUpdateMeaningsWithArray:objectsArr];
        }
    }
}

- (void)createOrUpdateMeaningsWithArray:(NSArray *)meanings
{
    [self.realm beginWriteTransaction];
    
    BOOL needRebuildIndex = NO;
    
    for (SEMeaningPonso *ponso in meanings)
    {
        RLMResults *results = [SEMeaningObject objectsInRealm:self.realm where:@"identifier = %ld", ponso.identifier];
        SEMeaningObject *object = nil;
        if (results.count > 0)
        {
            [object updateInRealm:self.realm withPonso:ponso];
        } else
        {
            object = [SEMeaningObject createInRealm:self.realm withPonso:ponso];
            needRebuildIndex = YES;
        }
    }
    
    if (needRebuildIndex)
    {
        [self rebuildRandomIndex];
    }
    
    [self.realm commitWriteTransaction];
}

- (void)rebuildRandomIndex
{
    BOOL needCommit = NO;
    if (![self.realm inWriteTransaction])
    {
        [self.realm beginWriteTransaction];
        needCommit = YES;
    }
    RLMResults *results = [SEMeaningObject allObjectsInRealm:self.realm];
    
    NSInteger rndIndex = 1;
    for (SEMeaningObject *object in results)
    {
        object.rnd_index = rndIndex;
        rndIndex++;
    }
    
    if (needCommit)
    {
        [self.realm commitWriteTransaction];
    }
}

#pragma mark - Public

- (NSArray *)meaningsIdsForRndIndexes:(NSArray *)indexes
{
    NSMutableArray *ids = [NSMutableArray new];
    RLMResults *results = [SEMeaningObject objectsInRealm:self.realm where:@"rnd_index IN %@", indexes];
    
    for (SEMeaningObject *object in results)
    {
        [ids addObject:@(object.identifier)];
    }
    
    return ids;
}

- (NSInteger)totalDictionarySize
{
    RLMResults *results = [SEMeaningObject allObjectsInRealm:self.realm];
    return results.count;
}

- (SEWordTaskPonso *)taskWithMeaningId:(NSInteger)meaningId
{
    RLMResults *results = [SEWordTaskObject objectsInRealm:self.realm where:@"meaningId = %ld", (long)meaningId];
    SEWordTaskObject *object = [results firstObject];
    SEWordTaskPonso *ponso = nil;
    if (object)
    {
        ponso = [object ponso];
    }
    
    return ponso;
}

- (void)addTasks:(NSArray *)tasks
{
    rlm_try_begin_transaction(self.realm)
    
    for (SEWordTaskPonso *ponso in tasks)
    {
        SEWordTaskObject *object = [SEWordTaskObject objectInRealm:self.realm forPrimaryKey:@(ponso.meaningId)];
        if (object)
        {
            [object updateInRealm:self.realm withPonso:ponso];
        } else
        {
            [SEWordTaskObject createInRealm:self.realm withPonso:ponso];
        }
    }
    
    rlm_try_commit_transaction(self.realm)
}

- (void)clearTasks
{
    rlm_try_begin_transaction(self.realm)
    
    RLMResults *results = [SEWordTaskObject allObjectsInRealm:self.realm];
    [self.realm deleteObjectsAndRelations:results];
    
    rlm_try_commit_transaction(self.realm)
}

@end
