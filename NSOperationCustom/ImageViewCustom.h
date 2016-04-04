//
//  ImageViewCustom.h
//  NSOperationCustom
//
//  Created by Nguyen Le Trong Nhan on 4/1/16.
//  Copyright © 2016 Nguyen Le Trong Nhan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ImageViewCustom : UIImageView

@property (strong, nonatomic) NSIndexPath *callbackIndex;
- (BOOL)isConformToIndexPath:(NSIndexPath *)indexPath;

@end
