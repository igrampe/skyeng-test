//
//  SEMeaningPonso.h
//  SkyEngTest
//
//  Created by Semyon Belokovsky on 16/04/16.
//  Copyright © 2016 igrampe. All rights reserved.
//

#import "SESerializableObject.h"

@interface SEMeaningPonso : SESerializableObject

@property (nonatomic, assign) NSInteger identifier;
@property (nonatomic, assign) NSInteger rnd_index;
@property (nonatomic, strong) NSString *name;

@end
