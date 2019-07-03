//
//  VideoStreamRequestHandler.h
//  PSPClient
//
//  Created by Bastek on 4/26/19.
//  Copyright © 2019 PeerStream, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PSPVideoStreamRequestHandler.h"


NS_ASSUME_NONNULL_BEGIN

typedef void (^VideoStreamRequestResponseHandler)(NSString *);
typedef void (^VideoStreamRequestFailureHandler)(PSPVideoStreamErrorId);


@interface VideoStreamRequestHandler : NSObject <PSPVideoStreamRequestHandler>

- (instancetype)init:(VideoStreamRequestResponseHandler)response
           onFailure:(VideoStreamRequestFailureHandler)failure;

@end

NS_ASSUME_NONNULL_END
