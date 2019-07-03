//
//  VideoStreamRequestHandler.m
//  PSPClient
//
//  Created by Bastek on 4/26/19.
//  Copyright © 2019 PeerStream, Inc. All rights reserved.
//

#import "VideoStreamRequestHandler.h"


@interface VideoStreamRequestHandler()

@property (nonatomic, strong) VideoStreamRequestResponseHandler response;
@property (nonatomic, strong) VideoStreamRequestFailureHandler failure;

@end


@implementation VideoStreamRequestHandler

- (instancetype)init:(VideoStreamRequestResponseHandler)response
           onFailure:(VideoStreamRequestFailureHandler)failure
{
    self = [super init];
    if (self) {
        self.response = response;
        self.failure = failure;
    }
    return self;
}

- (void)onVideoStreamStarted:(nonnull NSString *)streamId {
    self.response(streamId);
}

- (void)onVideoStreamError:(PSPVideoStreamErrorId)errorId {
    self.failure(errorId);
}

@end
