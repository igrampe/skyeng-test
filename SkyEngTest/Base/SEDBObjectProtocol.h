//
//  SEDBObjectProtocol.h
//  SkyEngTest
//
//  Created by Semyon Belokovsky on 17/04/16.
//  Copyright © 2016 igrampe. All rights reserved.
//

#ifndef SEDBObjectProtocol_h
#define SEDBObjectProtocol_h

@class RLMRealm;

@protocol SEDBObjectProtocol <NSObject>

- (void)deleteRelationsInRealm:(RLMRealm *)realm;
- (id)ponso;

@end

#endif /* SEDBObjectProtocol_h */
