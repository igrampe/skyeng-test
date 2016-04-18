//
//  SEApiManager.h
//  SkyEngTest
//
//  Created by Semyon Belokovsky on 15/04/16.
//  Copyright © 2016 igrampe. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^SEApiManagerGetObjectsHandler)(NSArray *objects, NSError *error);

@interface SEApiManager : NSObject

- (NSOperation *)apiGetWordTasksForMeaningIds:(NSArray *)ids
                                      handler:(SEApiManagerGetObjectsHandler)handler;

@end
