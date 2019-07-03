//
//  ChannelStreamHandler.m
//  PSPClient
//
//  Created by Bastek on 3/20/19.
//  Copyright © 2019 PeerStream, Inc. All rights reserved.
//

#import "ChannelStreamHandler.h"


@interface ChannelStreamHandler()

@property (nonatomic, strong) ChannelStreamHandlerResponseHandler response;
@property (nonatomic, strong) ChannelStreamHandlerFailureHandler failure;

@end


@implementation ChannelStreamHandler

- (instancetype)init:(ChannelStreamHandlerResponseHandler)response
           onFailure:(ChannelStreamHandlerFailureHandler)failure
{
    self = [super init];
    if (self) {
        self.response = response;
        self.failure = failure;
    }
    return self;
}

- (void)onStreamCreated:(nonnull NSString *)channelId streamId:(nonnull NSString *)streamId {
    self.response(streamId);
}

- (void)onStreamError:(nonnull NSString *)channelId errorId:(PSPVideoStreamErrorId)errorId { 
    self.failure(errorId);
}

@end
