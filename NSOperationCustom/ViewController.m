//
//  ViewController.m
//  NSOperationCustom
//
//  Created by Nguyen Le Trong Nhan on 3/31/16.
//  Copyright © 2016 Nguyen Le Trong Nhan. All rights reserved.
//

#import "ViewController.h"
#import "DownloadImage.h"
#import "BindingObject.h"
#import "TableViewCell.h"

@interface ImageDetail : NSObject

@property (nonatomic) BOOL isDownloaded;
@property (nonatomic, strong) UIImage* imgData;
@property (nonatomic, strong) NSString* imgUrl;

@end

@implementation ImageDetail
- (instancetype)init {
    self = [super init];
    if (self) {
        self.isDownloaded = NO;
        self.imgData = nil;
    }
    return self;
}

@end

@interface ViewController () <UITableViewDataSource, UITableViewDataSource, UIScrollViewDelegate>

{
    NSArray *listUrl;
    NSMutableArray *arrData;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    listUrl = [NSArray arrayWithObjects:@"http://www.planetware.com/photos-large/F/france-paris-eiffel-tower.jpg",@"http://adriatic-lines.com/wp-content/uploads/2015/04/canal-of-Venice.jpg",@"http://algoos.com/wp-content/uploads/2015/08/ireland-02.jpg",@"http://bdo.se/wp-content/uploads/2014/01/Stockholm1.jpg",nil];
    arrData = [NSMutableArray new];
    for (int i = 0; i< 20; i++) {
        int num = arc4random_uniform(4);
        ImageDetail *item = [[ImageDetail alloc] init];
        item.imgUrl = listUrl[num];
        [arrData addObject:item];
    }
    
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return arrData.count;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellID"];
    if (cell) {
        [cell.btn setTitle:[NSString stringWithFormat:@"%li",indexPath.row] forState:UIControlStateNormal];
        int num = arc4random_uniform(4);
        
        [cell.imgView setCallbackIndex:indexPath];
        ImageDetail *itemData = arrData[indexPath.row];
        if (itemData.isDownloaded == NO) {
            [BindGetSingleForProtocol(DownloadImageProtocol) downloadImage:itemData.imgUrl toImageView:cell.imgView withBlock:^(id responseData, int indexPathRow, BOOL success) {

                if (indexPathRow == indexPath.row) {
                    [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                        UIImage *img = (UIImage*)responseData;
                        
                        [cell.imgView setImage:img];
                        itemData.imgData = img;
                        itemData.isDownloaded = YES;
                           
                    }];
                }
                
            }];
        } else {
        
        [cell.imgView setImage:itemData.imgData];
        }
        
    }
    return cell;
}


@end
