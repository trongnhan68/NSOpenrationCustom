//
//  DownloadImage.m
//  NSOperationCustom
//
//  Created by Nguyen Le Trong Nhan on 3/31/16.
//  Copyright © 2016 Nguyen Le Trong Nhan. All rights reserved.
//

#import "DownloadImage.h"

@interface DownloadImage()

@property (strong, nonatomic) NSOperationQueue *queue;
@property (strong, nonatomic) NSMutableDictionary *downloadingIndexs;
@end

@implementation DownloadImage
- (instancetype)init {
    self = [super init];
    if (self) {
        _queue = [NSOperationQueue new];
        [_queue setMaxConcurrentOperationCount:4];
        _downloadingIndexs = [NSMutableDictionary new];
        
    }
    return self;
}

- (void)downloadImage:(NSString*)url toImageView:(ImageViewCustom*)imgView withBlock:(DownloadImageCallback)callback {
    
    NSString *key = [NSString stringWithFormat:@"%li",imgView.callbackIndex.row];
    
    if ([_downloadingIndexs objectForKey:key])
        return;
    [_downloadingIndexs setObject:@"OK" forKey:key];
    __weak ImageViewCustom *weakImage = imgView;
    
    NSBlockOperation *operation = [NSBlockOperation blockOperationWithBlock:^{
        NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:url]];
        
        if (data)  {
            callback([UIImage imageWithData:data],(int)weakImage.callbackIndex.row, YES);
            NSLog(@"Downloaded: %li", weakImage.callbackIndex.row);
        }
        else {
            callback(nil,0,NO);
            NSLog(@"Download Fail: %li",weakImage.callbackIndex.row);
        }
        [self removeDownloadingIndex:weakImage.callbackIndex.row];
        
    }];
    
    [self.queue addOperation:operation];
    
}

- (void)suspendAllOperation{
    self.queue.suspended = YES;

}
- (void)ressumeAllOperation{

    self.queue.suspended = NO;
}
- (void)removeDownloadingIndex:(int)index {
    
    NSString *key = [NSString stringWithFormat:@"%i",index];
    if ([_downloadingIndexs objectForKey:key]){
        [_downloadingIndexs removeObjectForKey:key];
        
    }
}


@end
