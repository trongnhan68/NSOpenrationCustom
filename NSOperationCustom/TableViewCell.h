//
//  TableViewCell.h
//  NSOperationCustom
//
//  Created by Nguyen Le Trong Nhan on 3/31/16.
//  Copyright © 2016 Nguyen Le Trong Nhan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ImageViewCustom.h"


@interface TableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIButton *btn;
@property (weak, nonatomic) IBOutlet ImageViewCustom *imgView;
@end
