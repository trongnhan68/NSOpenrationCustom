//
//  OperationCustom.m
//  NSOperationCustom
//
//  Created by Nguyen Le Trong Nhan on 4/5/16.
//  Copyright © 2016 Nguyen Le Trong Nhan. All rights reserved.
//

#import "OperationCustom.h"
#import "ViewController.h"

@interface OperationCustom()

@property (nonatomic) ImageDetail *mImageDetail;

@end
@implementation OperationCustom

- (instancetype)init {

    self = [super init];
    if (self) {
        //self.mImageDetail = [[ImageDetail alloc] init];
    
    }
    return self;
}
- (void)initWithImageDetail:(ImageDetail*)imageDetail{

    self.mImageDetail = imageDetail;
}

- (void)main {
    
    [super main];
    
    if (self.cancelled) {
        return;
    }

    NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:self.mImageDetail.imgUrl]];
    
    if (self.cancelled) {
        return;
    }
    
    
    if (data) {
       
        self.mImageDetail.isDownloaded = YES;
        self.mImageDetail.imgData = [UIImage imageWithData:data];
    } else {
        self.mImageDetail.isDownloaded = NO;
        self.mImageDetail.imgData = nil;;
    
    }
    
}




@end

@implementation PendingOperation

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.downloadsInProgress = [NSMutableDictionary new];
        self.downloadQueue = [NSOperationQueue new];
        self.downloadQueue.maxConcurrentOperationCount = 1;

    }
    return self;
}

@end

