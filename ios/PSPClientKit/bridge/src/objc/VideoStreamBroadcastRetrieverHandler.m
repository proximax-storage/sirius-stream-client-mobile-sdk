//
//  VideoStreamBroadcastRetrieverHandler.m
//  PSPClient
//
//  Created by Bastek on 4/26/19.
//  Copyright © 2019 PeerStream, Inc. All rights reserved.
//

#import "VideoStreamBroadcastRetrieverHandler.h"


@interface VideoStreamBroadcastRetrieverHandler()

@property (nonatomic, strong) VideoStreamBroadcastRetrieverResponseHandler response;

@end


@implementation VideoStreamBroadcastRetrieverHandler

- (instancetype)init:(VideoStreamBroadcastRetrieverResponseHandler)response {
    self = [super init];
    if (self) {
        self.response = response;
    }
    return self;
}

- (void)onRetrieveBroadcastStreamId:(nullable NSString *)streamId {
    self.response(streamId);
}

@end
