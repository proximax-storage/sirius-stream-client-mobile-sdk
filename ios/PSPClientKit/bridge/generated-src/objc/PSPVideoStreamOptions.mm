// AUTOGENERATED FILE - DO NOT MODIFY!
// This file generated by Djinni from VideoStreamer.djinni

#import "PSPVideoStreamOptions.h"


@implementation PSPVideoStreamOptions

- (nonnull instancetype)initWithAudioCaptureEnabled:(BOOL)audioCaptureEnabled
                               initialSpeakerVolume:(int32_t)initialSpeakerVolume
                                   initialMicVolume:(int32_t)initialMicVolume
                                videoCaptureEnabled:(BOOL)videoCaptureEnabled
                                     streamingWidth:(int32_t)streamingWidth
                                    streamingHeight:(int32_t)streamingHeight
                                        orientation:(PSPVideoFrameOrientation)orientation
{
    if (self = [super init]) {
        _audioCaptureEnabled = audioCaptureEnabled;
        _initialSpeakerVolume = initialSpeakerVolume;
        _initialMicVolume = initialMicVolume;
        _videoCaptureEnabled = videoCaptureEnabled;
        _streamingWidth = streamingWidth;
        _streamingHeight = streamingHeight;
        _orientation = orientation;
    }
    return self;
}

+ (nonnull instancetype)VideoStreamOptionsWithAudioCaptureEnabled:(BOOL)audioCaptureEnabled
                                             initialSpeakerVolume:(int32_t)initialSpeakerVolume
                                                 initialMicVolume:(int32_t)initialMicVolume
                                              videoCaptureEnabled:(BOOL)videoCaptureEnabled
                                                   streamingWidth:(int32_t)streamingWidth
                                                  streamingHeight:(int32_t)streamingHeight
                                                      orientation:(PSPVideoFrameOrientation)orientation
{
    return [(PSPVideoStreamOptions*)[self alloc] initWithAudioCaptureEnabled:audioCaptureEnabled
                                                        initialSpeakerVolume:initialSpeakerVolume
                                                            initialMicVolume:initialMicVolume
                                                         videoCaptureEnabled:videoCaptureEnabled
                                                              streamingWidth:streamingWidth
                                                             streamingHeight:streamingHeight
                                                                 orientation:orientation];
}

- (NSString *)description
{
    return [NSString stringWithFormat:@"<%@ %p audioCaptureEnabled:%@ initialSpeakerVolume:%@ initialMicVolume:%@ videoCaptureEnabled:%@ streamingWidth:%@ streamingHeight:%@ orientation:%@>", self.class, (void *)self, @(self.audioCaptureEnabled), @(self.initialSpeakerVolume), @(self.initialMicVolume), @(self.videoCaptureEnabled), @(self.streamingWidth), @(self.streamingHeight), @(self.orientation)];
}

@end
