//
//  ClientChannelHandler.m
//  PSPClient
//
//  Created by Bastek on 3/20/19.
//  Copyright © 2019 PeerStream, Inc. All rights reserved.
//

#import "ClientChannelHandler.h"


@interface ClientChannelHandler()

@property (nonatomic, strong) ClientChannelHandlerResponseHandler response;
@property (nonatomic, strong) ClientChannelHandlerFailureHandler failure;

@end


@implementation ClientChannelHandler

- (instancetype)init:(ClientChannelHandlerResponseHandler)response
           onFailure:(ClientChannelHandlerFailureHandler)failure
{
    self = [super init];
    if (self) {
        self.response = response;
        self.failure = failure;
    }
    return self;
}

- (void)onChannelCreated:(nonnull NSString *)clientId
                 channel:(nullable PSPChannel *)channel
{
    self.response(clientId, channel);
}

- (void)onChannelConfirmed:(nonnull NSString *)clientId
                   channel:(nullable PSPChannel *)channel
{
    self.response(clientId, channel);
}

- (void)onChannelResponseError:(nonnull NSString *)clientId
                       errorId:(PSPChannelRequestErrorId)errorId
{
    self.failure(clientId, errorId);
}


- (void)onChannelError:(nonnull NSString *)clientId
               errorId:(PSPChannelRequestErrorId)errorId
{
    self.failure(clientId, errorId);
}


@end
