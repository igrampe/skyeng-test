//
//  SEWordTaskPonso.h
//  SkyEngTest
//
//  Created by Semyon Belokovsky on 17/04/16.
//  Copyright © 2016 igrampe. All rights reserved.
//

#import "SESerializableObject.h"

@interface SEWordTaskPonso : SESerializableObject

@property (nonatomic, assign) NSInteger meaningId;
@property (nonatomic, strong) NSString *posCode;
@property (nonatomic, strong) NSString *text;
@property (nonatomic, strong) NSString *translation;
@property (nonatomic, strong) NSString *definition;
@property (nonatomic, strong) NSString *transcription;
@property (nonatomic, strong) NSString *soundUrl;
@property (nonatomic, strong) NSArray *images;
@property (nonatomic, strong) NSArray *alternatives;

@end
