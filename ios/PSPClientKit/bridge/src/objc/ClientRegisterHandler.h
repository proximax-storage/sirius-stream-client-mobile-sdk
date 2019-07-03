//
//  ClientRegisterHandler.h
//  PSPClient
//
//  Created by Bastek on 3/20/19.
//  Copyright © 2019 PeerStream, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "PSPClientRegistrationData.h"
#import "PSPClientRegisterFailureCode.h"
#import "PSPClientRegisterHandler.h"



NS_ASSUME_NONNULL_BEGIN

typedef void (^ClientRegisterHandlerResponseHandler)(PSPClientRegistrationData *);
typedef void (^ClientRegisterHandlerFailureHandler)(PSPClientRegisterFailureCode);


@interface ClientRegisterHandler : NSObject <PSPClientRegisterHandler>

- (instancetype)init:(ClientRegisterHandlerResponseHandler)response
           onFailure:(ClientRegisterHandlerFailureHandler)failure;

@end

NS_ASSUME_NONNULL_END

