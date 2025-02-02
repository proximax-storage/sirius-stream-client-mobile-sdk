// AUTOGENERATED FILE - DO NOT MODIFY!
// This file generated by Djinni from ClientApp.djinni

#import "PSPClientAppExitCode.h"
#import "PSPClientNetworkStatus.h"
#import <Foundation/Foundation.h>


@protocol PSPClientAppObserver

- (void)onApplicationReady:(nonnull NSString *)clientId;

- (void)onApplicationExit:(PSPClientAppExitCode)code;

- (void)onChannelRequested:(nonnull NSString *)clientId
                    userId:(nonnull NSString *)userId;

- (void)onNetworkStatus:(nonnull NSString *)clientId
                 status:(nonnull PSPClientNetworkStatus *)status;

- (void)onUserPresenceChange:(nonnull NSString *)clientId
                      userId:(nonnull NSString *)userId
                    isActive:(BOOL)isActive;

@end
