//
//  ClientRegisterHandler.m
//  PSPClient
//
//  Created by Bastek on 3/20/19.
//  Copyright © 2019 PeerStream, Inc. All rights reserved.
//

#import "ClientRegisterHandler.h"


@interface ClientRegisterHandler()

@property (nonatomic, strong) ClientRegisterHandlerResponseHandler response;
@property (nonatomic, strong) ClientRegisterHandlerFailureHandler failure;

@end


@implementation ClientRegisterHandler

- (instancetype)init:(ClientRegisterHandlerResponseHandler)response
           onFailure:(ClientRegisterHandlerFailureHandler)failure
{
    self = [super init];
    if (self) {
        self.response = response;
        self.failure = failure;
    }
    return self;
}

- (void)onRegisterSuccess:(nonnull NSString *)clientId userData:(nonnull PSPClientRegistrationData *)userData {
    self.response(userData);
}

- (void)onRegisterFailure:(nonnull NSString *)clientId code:(PSPClientRegisterFailureCode)code {
    self.failure(code);
}

@end
