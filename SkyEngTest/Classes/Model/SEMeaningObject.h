//
//  SEMeaningObject.h
//  SkyEngTest
//
//  Created by Semyon Belokovsky on 16/04/16.
//  Copyright © 2016 igrampe. All rights reserved.
//

#import "SEDBObject.h"

@class SEMeaningPonso;

@interface SEMeaningObject : SEDBObject

@property (nonatomic, assign) NSInteger identifier;
@property (nonatomic, assign) NSInteger rnd_index;
@property (nonatomic, strong) NSString *name;

- (SEMeaningPonso *)ponso;
- (void)updateInRealm:(RLMRealm *)realm withPonso:(SEMeaningPonso *)ponso;
+ (instancetype)createInRealm:(RLMRealm *)realm withPonso:(SEMeaningPonso *)ponso;

@end
