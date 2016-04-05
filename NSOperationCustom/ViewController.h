//
//  ViewController.h
//  NSOperationCustom
//
//  Created by Nguyen Le Trong Nhan on 3/31/16.
//  Copyright © 2016 Nguyen Le Trong Nhan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OperationCustom.h"



@interface ViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic) PendingOperation *pendingOperation;

@end

@interface ImageDetail : NSObject

@property (nonatomic) BOOL isDownloaded;
@property (nonatomic, strong) UIImage* imgData;
@property (nonatomic, strong) NSString* imgUrl;

@end