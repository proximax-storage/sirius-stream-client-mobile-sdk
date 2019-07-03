// AUTOGENERATED FILE - DO NOT MODIFY!
// This file generated by Djinni from ClientApp.djinni

#import "PSPChannelRequestErrorId.h"
#import <Foundation/Foundation.h>
@class PSPChannel;


@protocol PSPClientChannelHandler

- (void)onChannelConfirmed:(nonnull NSString *)clientId
                   channel:(nullable PSPChannel *)channel;

- (void)onChannelResponseError:(nonnull NSString *)clientId
                       errorId:(PSPChannelRequestErrorId)errorId;

@end
