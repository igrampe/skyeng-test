//
//  SEStringObject.h
//  SkyEngTest
//
//  Created by Semyon Belokovsky on 17/04/16.
//  Copyright © 2016 igrampe. All rights reserved.
//

#import <Realm/Realm.h>

@interface SEStringObject : RLMObject

@property (nonatomic, strong) NSString *value;

- (void)updateInRealm:(RLMRealm *)realm withValue:(NSString *)value;
+ (instancetype)createInRealm:(RLMRealm *)realm withValue:(NSString *)value;

@end

RLM_ARRAY_TYPE(SEStringObject)
