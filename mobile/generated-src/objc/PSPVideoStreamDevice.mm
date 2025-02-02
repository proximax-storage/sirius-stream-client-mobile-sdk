// AUTOGENERATED FILE - DO NOT MODIFY!
// This file generated by Djinni from VideoStreamer.djinni

#import "PSPVideoStreamDevice.h"


@implementation PSPVideoStreamDevice

- (nonnull instancetype)initWithName:(nonnull NSString *)name
                          identifier:(nonnull NSString *)identifier
                   videoCapabilities:(nonnull NSArray<PSPVideoStreamCapability *> *)videoCapabilities
{
    if (self = [super init]) {
        _name = [name copy];
        _identifier = [identifier copy];
        _videoCapabilities = [videoCapabilities copy];
    }
    return self;
}

+ (nonnull instancetype)VideoStreamDeviceWithName:(nonnull NSString *)name
                                       identifier:(nonnull NSString *)identifier
                                videoCapabilities:(nonnull NSArray<PSPVideoStreamCapability *> *)videoCapabilities
{
    return [(PSPVideoStreamDevice*)[self alloc] initWithName:name
                                                  identifier:identifier
                                           videoCapabilities:videoCapabilities];
}

- (NSString *)description
{
    return [NSString stringWithFormat:@"<%@ %p name:%@ identifier:%@ videoCapabilities:%@>", self.class, (void *)self, self.name, self.identifier, self.videoCapabilities];
}

@end
