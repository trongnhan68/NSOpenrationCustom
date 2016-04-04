//
//  BindingObject.m
//  NSOperationCustom
//
//  Created by Nguyen Le Trong Nhan on 3/31/16.
//  Copyright © 2016 Nguyen Le Trong Nhan. All rights reserved.
//

#import "BindingObject.h"
#import "DownloadImage.h"


static NSMutableDictionary *key_class = nil;
static NSMutableDictionary *key_object = nil; // for single bind

@implementation BindingObject

+ (void)initOrReset
{
    key_class = [NSMutableDictionary new];
    key_object = [NSMutableDictionary new];
    
    // Configs
    [self bindSingle:@protocol(DownloadImageProtocol) withObject:[DownloadImage new]];

}
+ (void)bindSingle:(Protocol *)protocol withObject:(id)object
{
    if ([object conformsToProtocol:protocol]) {
        NSString *key = NSStringFromProtocol(protocol);
        [key_object setObject:object forKey:key];
    }

}

+ (void)bind:(Protocol *)protocol withClass:(Class)cla
{
    if ([cla conformsToProtocol:protocol]) {
        NSString *key = NSStringFromProtocol(protocol);
        [key_class setObject:cla forKey:key];
    } else {
#if DEBUG
        NSAssert(FALSE, @"Bind failed, class is not conformed to protocol");
#endif
    }
}

+ (id)objectSingleForProtocol:(Protocol *)protocol
{
    return [key_object objectForKey:NSStringFromProtocol(protocol)];
}


+ (id)objectForProtocol:(Protocol *)protocol
{
    NSString *key = NSStringFromProtocol(protocol);
    Class cla = [key_class objectForKey:key];
    id object = [cla new];
    return object;
}

@end
