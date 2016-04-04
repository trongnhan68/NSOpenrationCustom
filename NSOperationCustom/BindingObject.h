//
//  BindingObject.h
//  NSOperationCustom
//
//  Created by Nguyen Le Trong Nhan on 3/31/16.
//  Copyright © 2016 Nguyen Le Trong Nhan. All rights reserved.
//

#import <Foundation/Foundation.h>

#define BindGetSingleForProtocol(X) (id<X>)[BindingObject objectSingleForProtocol:@protocol(X)]
#define BindGetObjectForProtocol(X) (id<X>)[BindingObject objectForProtocol:@protocol(X)]

@interface BindingObject : NSObject
+ (void)initOrReset;

+ (void)bindSingle:(Protocol *)protocol withObject:(id)object;
+ (void)bind:(Protocol *)protocol withClass:(Class)cla;

+ (id)objectForProtocol:(Protocol *)protocol;
+ (id)objectSingleForProtocol:(Protocol *)protocol;
@end
