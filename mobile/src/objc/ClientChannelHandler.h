//
//  ClientChannelHandler.h
//  PSPClient
//
//  Created by Bastek on 3/20/19.
//  Copyright © 2019 PeerStream, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PSPClientChannelHandler.h"



NS_ASSUME_NONNULL_BEGIN

typedef void (^ClientChannelHandlerResponseHandler)(NSString*, PSPChannel*);
typedef void (^ClientChannelHandlerFailureHandler)(NSString*, PSPChannelRequestErrorId);


@interface ClientChannelHandler : NSObject <PSPClientChannelHandler>

- (instancetype)init:(ClientChannelHandlerResponseHandler)response
           onFailure:(ClientChannelHandlerFailureHandler)failure;

@end

NS_ASSUME_NONNULL_END

