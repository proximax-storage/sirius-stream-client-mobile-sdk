//
//  ClientLoginHandler.m
//  PSPClient
//
//  Created by Bastek on 3/20/19.
//  Copyright © 2019 PeerStream, Inc. All rights reserved.
//

#import "ClientLoginHandler.h"


@interface ClientLoginHandler()

@property (nonatomic, strong) ClientLoginHandlerResponseHandler response;
@property (nonatomic, strong) ClientLoginHandlerFailureHandler failure;

@end


@implementation ClientLoginHandler

- (instancetype)init:(ClientLoginHandlerResponseHandler)response
           onFailure:(ClientLoginHandlerFailureHandler)failure
{
    self = [super init];
    if (self) {
        self.response = response;
        self.failure = failure;
    }
    return self;
}

- (void)onLoginSuccess:(NSString *)clientId
              response:(NSString *)response
                  data:(PSPClientRegistrationData *)data
{
    self.response(response, data);
}

- (void)onLoginFailure:(nonnull NSString *)clientId
                  code:(PSPClientLoginFailureCode)code
{
    self.failure(code);
}

@end
