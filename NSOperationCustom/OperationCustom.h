//
//  OperationCustom.h
//  NSOperationCustom
//
//  Created by Nguyen Le Trong Nhan on 4/5/16.
//  Copyright © 2016 Nguyen Le Trong Nhan. All rights reserved.
//

#import <Foundation/Foundation.h>


@class ImageDetail;


@interface OperationCustom : NSOperation

- (void)initWithImageDetail:(ImageDetail*)imageDetail;

@end
@interface PendingOperation : NSObject

@property (nonatomic, strong) NSMutableDictionary *downloadsInProgress;
@property (nonatomic, strong) NSOperationQueue *downloadQueue;

@end
