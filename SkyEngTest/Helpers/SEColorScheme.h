//
//  SEColorScheme.h
//  SkyEngTest
//
//  Created by Semyon Belokovsky on 18/04/16.
//  Copyright © 2016 igrampe. All rights reserved.
//

#import "APLColorScheme.h"
#import "ColorSchemeHeader.h"

@interface SEColorScheme : APLColorScheme

@end

#define SECSC(x) ([SEColorScheme colorWithName:x])
