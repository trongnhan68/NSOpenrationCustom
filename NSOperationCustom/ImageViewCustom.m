//
//  ImageViewCustom.m
//  NSOperationCustom
//
//  Created by Nguyen Le Trong Nhan on 4/1/16.
//  Copyright © 2016 Nguyen Le Trong Nhan. All rights reserved.
//

#import "ImageViewCustom.h"

@implementation ImageViewCustom

- (BOOL)isConformToIndexPath:(NSIndexPath *)indexPath
{
    if (self.callbackIndex && [self.callbackIndex compare:indexPath] == NSOrderedSame)
        return TRUE;
    
    return FALSE;
}

@end
