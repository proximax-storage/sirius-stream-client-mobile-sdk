// AUTOGENERATED FILE - DO NOT MODIFY!
// This file generated by Djinni from Channel.djinni

#import <Foundation/Foundation.h>
@protocol PSPChannelObserver;
@protocol PSPChannelStreamHandler;


@interface PSPChannel : NSObject

- (void)setObserver:(nullable id<PSPChannelObserver>)observer;

- (void)sendRawData:(nonnull NSData *)data;

- (void)sendMessage:(nonnull NSString *)msg;

- (void)close;

- (void)shareStream:(nullable id<PSPChannelStreamHandler>)handler;

- (void)requestStream:(nullable id<PSPChannelStreamHandler>)handler;

- (void)confirmVideoStreamRequest:(nullable id<PSPChannelStreamHandler>)handler;

- (void)denyVideoStreamRequest;

- (void)confirmVideoStreamShare:(nullable id<PSPChannelStreamHandler>)handler;

- (void)denyVideoStreamShare;

- (void)stopViewingStream;

- (BOOL)isConfirmed;

- (nonnull NSString *)getIdentity;

@end
