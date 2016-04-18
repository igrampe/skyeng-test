//
//  SEWordTaskAlternativeObject.h
//  SkyEngTest
//
//  Created by Semyon Belokovsky on 17/04/16.
//  Copyright © 2016 igrampe. All rights reserved.
//

#import "SEDBObject.h"

@class SEWordTaskAlternativePonso;

@interface SEWordTaskAlternativeObject : SEDBObject

@property (nonatomic, strong) NSString *text;
@property (nonatomic, strong) NSString *translation;

- (void)updateInRealm:(RLMRealm *)realm withPonso:(SEWordTaskAlternativePonso *)ponso;
+ (instancetype)createInRealm:(RLMRealm *)realm withPonso:(SEWordTaskAlternativePonso *)ponso;

- (SEWordTaskAlternativePonso *)ponso;

@end

RLM_ARRAY_TYPE(SEWordTaskAlternativeObject);
