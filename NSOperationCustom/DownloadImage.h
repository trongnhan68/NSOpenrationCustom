//
//  DownloadImage.h
//  NSOperationCustom
//
//  Created by Nguyen Le Trong Nhan on 3/31/16.
//  Copyright © 2016 Nguyen Le Trong Nhan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "ImageViewCustom.h"


typedef void(^DownloadImageCallback)(id responseData, int indexPathRow, BOOL success);


@protocol DownloadImageProtocol <NSObject>

- (void)downloadImage:(NSString*)url toImageView:(ImageViewCustom*)imgView withBlock:(DownloadImageCallback)callback;
- (void)removeDownloadingIndex:(int)index;
- (void)suspendAllOperation;
- (void)ressumeAllOperation;


@end

@interface DownloadImage : NSObject<DownloadImageProtocol>


@end
