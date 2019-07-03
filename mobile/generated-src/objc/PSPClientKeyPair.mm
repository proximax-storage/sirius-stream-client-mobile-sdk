// AUTOGENERATED FILE - DO NOT MODIFY!
// This file generated by Djinni from ClientApp.djinni

#import "PSPClientKeyPair.h"


@implementation PSPClientKeyPair

- (nonnull instancetype)initWithPublicKey:(nonnull NSString *)publicKey
                               privateKey:(nonnull NSString *)privateKey
{
    if (self = [super init]) {
        _publicKey = [publicKey copy];
        _privateKey = [privateKey copy];
    }
    return self;
}

+ (nonnull instancetype)ClientKeyPairWithPublicKey:(nonnull NSString *)publicKey
                                        privateKey:(nonnull NSString *)privateKey
{
    return [(PSPClientKeyPair*)[self alloc] initWithPublicKey:publicKey
                                                   privateKey:privateKey];
}

- (NSString *)description
{
    return [NSString stringWithFormat:@"<%@ %p publicKey:%@ privateKey:%@>", self.class, (void *)self, self.publicKey, self.privateKey];
}

@end
