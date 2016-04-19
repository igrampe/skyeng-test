//
//  UICollectionView+Helpers.m
//  SkyEngTest
//
//  Created by Semyon Belokovsky on 19/04/16.
//  Copyright © 2016 igrampe. All rights reserved.
//

#import "UICollectionView+Helpers.h"

@implementation UICollectionView (Helpers)

- (BOOL)hasCellAtIndexPath:(NSIndexPath *)indexPath
{
    BOOL result = NO;
    if ([self numberOfSections] > indexPath.section)
    {
        if ([self numberOfItemsInSection:indexPath.section] > indexPath.row)
        {
            result = YES;
        }
    }
    return result;
}

@end
