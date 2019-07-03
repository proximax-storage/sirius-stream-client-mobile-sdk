//
//  VideoStreamBroadcastRetrieverHandler.h
//  PSPClient
//
//  Created by Bastek on 4/26/19.
//  Copyright © 2019 PeerStream, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PSPVideoStreamBroadcastRetrieverHandler.h"


NS_ASSUME_NONNULL_BEGIN

typedef void (^VideoStreamBroadcastRetrieverResponseHandler)(NSString *);


@interface VideoStreamBroadcastRetrieverHandler : NSObject <PSPVideoStreamBroadcastRetrieverHandler>

- (instancetype)init:(VideoStreamBroadcastRetrieverResponseHandler)response;

@end

NS_ASSUME_NONNULL_END
