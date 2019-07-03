//
//  ClientLoginHandler.h
//  PSPClient
//
//  Created by Bastek on 3/20/19.
//  Copyright © 2019 PeerStream, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PSPClientLoginHandler.h"



NS_ASSUME_NONNULL_BEGIN

typedef void (^ClientLoginHandlerResponseHandler)(NSString *, PSPClientRegistrationData *);
typedef void (^ClientLoginHandlerFailureHandler)(PSPClientLoginFailureCode);


@interface ClientLoginHandler : NSObject <PSPClientLoginHandler>

- (instancetype)init:(ClientLoginHandlerResponseHandler)response
           onFailure:(ClientLoginHandlerFailureHandler)failure;

@end

NS_ASSUME_NONNULL_END

