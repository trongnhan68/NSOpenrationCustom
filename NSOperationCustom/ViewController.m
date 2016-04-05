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
    
    self.pendingOperation = [[PendingOperation alloc] init];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return arrData.count;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellID"];
    if (cell) {
        [cell.btn setTitle:[NSString stringWithFormat:@"%li",indexPath.row] forState:UIControlStateNormal];
        ImageDetail *itemData = arrData[indexPath.row];
        [cell.imgView setImage:itemData.imgData];
        
        if (itemData.isDownloaded == NO) {
            [self startDownloadForRecord:itemData indexPath:indexPath];
        }
        
    }
    return cell;
}

- (void) startDownloadForRecord:(ImageDetail*)photoDetail indexPath:(NSIndexPath*)indexPath {

    if (photoDetail.isDownloaded == YES) return;
    
    
    if ([self.pendingOperation.downloadsInProgress objectForKey:indexPath]) {
        return;
    }

    OperationCustom *downloader = [[OperationCustom alloc] init];
    [downloader initWithImageDetail:photoDetail];
    __weak OperationCustom *weakDownloader = downloader;
    downloader.completionBlock = ^{
        if (weakDownloader.cancelled) {
            return;
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            
            NSLog(@"Downloaded: %li", indexPath.row);
            
            [self.pendingOperation.downloadsInProgress removeObjectForKey:indexPath];
            [self.tableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade ];
        });
        
    };
    
    [self.pendingOperation.downloadsInProgress setObject:downloader forKey:indexPath];
    [self.pendingOperation.downloadQueue addOperation:downloader];
    
    
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    
    [self suspendAllOperation];
    
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    [self reloadVisibleCell];
    [self ressumeAllOperation];
    
}
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    
    
    if (decelerate == NO) {
        [self reloadVisibleCell];
        [self ressumeAllOperation];
        
    }
}
- (void)suspendAllOperation{
    self.pendingOperation.downloadQueue.suspended = YES;
    
}
- (void)ressumeAllOperation{
    
    self.pendingOperation.downloadQueue.suspended = NO;
}


- (void) reloadVisibleCell{
    [self cancelPendingOpenration];
    
    for (TableViewCell *cell in self.tableView.visibleCells) {
        NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
        ImageDetail *itemData = arrData[indexPath.row];
        [self startDownloadForRecord:itemData indexPath:indexPath];
        
    }

}

- (void)cancelPendingOpenration{

  
    NSArray *listKeys = [self.pendingOperation.downloadsInProgress allKeys];
    for (NSIndexPath *index in listKeys) {
    
        [[self.pendingOperation.downloadsInProgress objectForKey:index] cancel];
        [self.pendingOperation.downloadsInProgress removeObjectForKey:index];
    }
    

}


@end
