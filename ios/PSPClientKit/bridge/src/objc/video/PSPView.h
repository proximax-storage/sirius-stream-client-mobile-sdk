//
//  PSPView.h
//  PSPClient
//
//  Created by Bastek on 5/9/19.
//  Copyright © 2019 PeerStream, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

// Only use legacy OpenGL for running on simulators
#if TARGET_OS_IOS
    #import <GLKit/GLKit.h>
#else
    @import MetalKit;
#endif


NS_SWIFT_NAME(VideoScaleBehavior)
typedef NS_ENUM(NSInteger, PSPVideoScaleBehavior) {
    PSPVideoScaleBehaviorFit,
    PSPVideoScaleBehaviorFill,
};


#if TARGET_OS_IOS
@interface PSPView : GLKView
#else
@interface PSPView : MTKView
#endif

@property(nonatomic) PSPVideoScaleBehavior scaleBehavior;

- (void)update:(NSData *)buffer
         width:(NSUInteger)width
        height:(NSUInteger)height;
- (void)cleanup;

@end
