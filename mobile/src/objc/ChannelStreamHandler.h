//
//  ChannelStreamHandler.h
//  PSPClient
//
//  Created by Bastek on 3/20/19.
//  Copyright © 2019 PeerStream, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PSPChannelStreamHandler.h"



NS_ASSUME_NONNULL_BEGIN

typedef void (^ChannelStreamHandlerResponseHandler)(NSString *);
typedef void (^ChannelStreamHandlerFailureHandler)(PSPVideoStreamErrorId);


@interface ChannelStreamHandler : NSObject <PSPChannelStreamHandler>

- (instancetype)init:(ChannelStreamHandlerResponseHandler)response
           onFailure:(ChannelStreamHandlerFailureHandler)failure;

@end

NS_ASSUME_NONNULL_END
