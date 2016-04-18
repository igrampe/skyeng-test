//
//  SEWordTaskObject.h
//  SkyEngTest
//
//  Created by Semyon Belokovsky on 17/04/16.
//  Copyright © 2016 igrampe. All rights reserved.
//

#import "SEDBObject.h"
#import "SEStringObject.h"
#import "SEWordTaskAlternativeObject.h"

@class SEWordTaskPonso;

@interface SEWordTaskObject : SEDBObject

@property (nonatomic, assign) NSInteger meaningId;
@property (nonatomic, strong) NSString *posCode;
@property (nonatomic, strong) NSString *text;
@property (nonatomic, strong) NSString *translation;
@property (nonatomic, strong) NSString *definition;
@property (nonatomic, strong) NSString *transcription;
@property (nonatomic, strong) NSString *soundUrl;
@property (nonatomic, strong) RLMArray<SEStringObject> *images;
@property (nonatomic, strong) RLMArray<SEWordTaskAlternativeObject> *alternatives;

- (SEWordTaskPonso *)ponso;
- (void)updateInRealm:(RLMRealm *)realm withPonso:(SEWordTaskPonso *)ponso;
+ (instancetype)createInRealm:(RLMRealm *)realm withPonso:(SEWordTaskPonso *)ponso;

@end
