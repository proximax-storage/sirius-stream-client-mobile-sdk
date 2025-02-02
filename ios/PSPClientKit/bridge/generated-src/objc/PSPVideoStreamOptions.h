// AUTOGENERATED FILE - DO NOT MODIFY!
// This file generated by Djinni from VideoStreamer.djinni

#import "PSPVideoFrameOrientation.h"
#import <Foundation/Foundation.h>

@interface PSPVideoStreamOptions : NSObject
- (nonnull instancetype)initWithAudioCaptureEnabled:(BOOL)audioCaptureEnabled
                               initialSpeakerVolume:(int32_t)initialSpeakerVolume
                                   initialMicVolume:(int32_t)initialMicVolume
                                videoCaptureEnabled:(BOOL)videoCaptureEnabled
                                     streamingWidth:(int32_t)streamingWidth
                                    streamingHeight:(int32_t)streamingHeight
                                        orientation:(PSPVideoFrameOrientation)orientation;
+ (nonnull instancetype)VideoStreamOptionsWithAudioCaptureEnabled:(BOOL)audioCaptureEnabled
                                             initialSpeakerVolume:(int32_t)initialSpeakerVolume
                                                 initialMicVolume:(int32_t)initialMicVolume
                                              videoCaptureEnabled:(BOOL)videoCaptureEnabled
                                                   streamingWidth:(int32_t)streamingWidth
                                                  streamingHeight:(int32_t)streamingHeight
                                                      orientation:(PSPVideoFrameOrientation)orientation;

@property (nonatomic, readonly) BOOL audioCaptureEnabled;

@property (nonatomic, readonly) int32_t initialSpeakerVolume;

@property (nonatomic, readonly) int32_t initialMicVolume;

@property (nonatomic, readonly) BOOL videoCaptureEnabled;

@property (nonatomic, readonly) int32_t streamingWidth;

@property (nonatomic, readonly) int32_t streamingHeight;

@property (nonatomic, readonly) PSPVideoFrameOrientation orientation;

@end
