//
//  PSPView.m
//  PSPClient
//
//  Created by Bastek on 5/9/19.
//  Copyright © 2019 PeerStream, Inc. All rights reserved.
//

#import "PSPView.h"

// OpenGL
# pragma mark - OpenGL -
#if TARGET_OS_IOS

#import "frag_shader_fullplanar.h"
#import "vertex_shader.h"

#import <OpenGLES/EAGL.h>
#import <OpenGLES/ES2/glext.h>
#import <OpenGLES/ES2/gl.h>


/*
 * PRAGMA MARK: PSPView
 */

@interface PSPView() {
    GLuint program;

    GLuint lumaTexture;
    GLuint uChromaTexture;
    GLuint vChromaTexture;

    GLuint indexVBO;
    GLuint positionVBO;
    GLuint texcoordVBO;

    GLsizei gl_width;
    GLsizei gl_height;

    BOOL hasLoadedGL;
}

@property(nonatomic, strong) NSData* pixel;
@property(nonatomic) NSUInteger width;
@property(nonatomic) NSUInteger height;

@property(nonatomic) CGRect currentFrame;
@property(nonatomic) CGFloat currentAspectRatio;

@end


@implementation PSPView

/*
 * PRAGMA MARK: - Setup/Teardown
 */
- (instancetype)init {
    return [self initWithFrame:CGRectZero];
}


- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    [NSException raise:(@"InitializationException")
                format:@"[PSPView initWithCoder:] not available. Internal class - not meant to be used within Storyboard/Nib."];
    return nil;
}


- (instancetype)initWithFrame:(CGRect)frame {
    return [self initWithFrame:frame
                       context:[[EAGLContext alloc] initWithAPI:kEAGLRenderingAPIOpenGLES2]];
}


- (instancetype)initWithFrame:(CGRect)frame context:(EAGLContext *)context {
    self = [super initWithFrame:frame context:context];
    if (self) {
        [EAGLContext setCurrentContext:self.context];
        [self setup];
    }
    return self;
}


- (void)setup {
    NSLog(@"Setting up YUV view...");

    // defaults:
    _scaleBehavior = PSPVideoScaleBehaviorFill;
    _currentFrame = self.frame;
}


// Uniform index.
enum {
    UNIFORM_MVP,
    UNIFORM_Y,
    UNIFORM_U,
    UNIFORM_V,
    NUM_UNIFORMS
};
GLint uniforms[NUM_UNIFORMS];

// Attribute index.
enum {
    ATTRIB_VERTEX,
    ATTRIB_TEXCOORD,
    NUM_ATTRIBUTES
};


- (void)setupBuffers {
    float x1 = -1.0;
    float y1 = -1.0;
    float x2 = 1.0;
    float y2 = 1.0;

    float u1 = 0.0;
    float v1 = 0.0;
    float u2 = 1.0;
    float v2 = 1.0;

    GLfloat vertices[] = {
        x1, y1,
        x1, y2,
        x2, y2,
        x2, y1
    };

    GLfloat texCoords[] = {
        u1, v1,
        u1, v2,
        u2, v2,
        u2, v1
    };

    GLushort indices[] = {
        0, 1, 2, 3
    };

    glGenBuffers(1, &indexVBO);
    glBindBuffer(GL_ELEMENT_ARRAY_BUFFER, indexVBO);
    glBufferData(GL_ELEMENT_ARRAY_BUFFER, sizeof(indices), indices, GL_STATIC_DRAW);

    glGenBuffers(1, &positionVBO);
    glBindBuffer(GL_ARRAY_BUFFER, positionVBO);
    glBufferData(GL_ARRAY_BUFFER, sizeof(vertices), vertices, GL_STATIC_DRAW);

    glEnableVertexAttribArray(ATTRIB_VERTEX);
    glVertexAttribPointer(ATTRIB_VERTEX, 2, GL_FLOAT, GL_FALSE, 2*sizeof(GLfloat), 0);

    glGenBuffers(1, &texcoordVBO);
    glBindBuffer(GL_ARRAY_BUFFER, texcoordVBO);
    glBufferData(GL_ARRAY_BUFFER, sizeof(texCoords), texCoords, GL_STATIC_DRAW);

    glEnableVertexAttribArray(ATTRIB_TEXCOORD);
    glVertexAttribPointer(ATTRIB_TEXCOORD, 2, GL_FLOAT, GL_FALSE, 2*sizeof(GLfloat), 0);
}


- (BOOL)compileShader:(GLuint *)shader type:(GLenum)type cstring:(char *)shader_string {
    NSLog(@"Compiling YUV view shaders...");
    GLint status;
    const GLchar *source = shader_string;
    *shader = glCreateShader(type);
    glShaderSource(*shader, 1, &source, NULL);
    glCompileShader(*shader);
    GLint logLength;
    glGetShaderiv(*shader, GL_INFO_LOG_LENGTH, &logLength);
    if (logLength > 0) {
        GLchar *log = (GLchar *)malloc(logLength);
        glGetShaderInfoLog(*shader, logLength, &logLength, log);
        NSLog(@"Shader compile log:\n%s", log);
        free(log);
    }
    glGetShaderiv(*shader, GL_COMPILE_STATUS, &status);
    if (status == 0) {
        NSLog(@"Shader compilation failed with status==0, releasing resources and exiting.");
        glDeleteShader(*shader);
        return NO;
    }

    NSLog(@"Shader compilation successful");
    return YES;
}


- (BOOL)loadGL {
    NSLog(@"Setting up GL for YUV view");

    GLuint vertShader, fragShader;
    program = glCreateProgram();

    if (![self compileShader:&vertShader type:GL_VERTEX_SHADER cstring:vertex_shader_c_string]) {
        NSLog(@"Failed to compile vertex shader");
        return NO;
    }

    if (![self compileShader:&fragShader type:GL_FRAGMENT_SHADER cstring:frag_shader_c_string]) {
        NSLog(@"Failed to compile fragment shader");
        return NO;
    }

    glAttachShader(program, vertShader);
    glAttachShader(program, fragShader);
    glBindAttribLocation(program, ATTRIB_VERTEX, "position");
    glBindAttribLocation(program, ATTRIB_TEXCOORD, "texCoord");

    // Link Program
    GLint status;
    glLinkProgram(program);

    GLint logLength;
    glGetProgramiv(program, GL_INFO_LOG_LENGTH, &logLength);
    if (logLength > 0) {
        GLchar *log = (GLchar *)malloc(logLength);
        glGetProgramInfoLog(program, logLength, &logLength, log);
        NSLog(@"Program link log:\n%s", log);
        free(log);
    }
    glGetProgramiv(program, GL_LINK_STATUS, &status);

    // ok to clean up shaders now
    if (vertShader) {
        glDetachShader(program, vertShader);
        glDeleteShader(vertShader);
    }
    if (fragShader) {
        glDetachShader(program, fragShader);
        glDeleteShader(fragShader);
    }

    if (status == 0) {
        [self unloadGL];
        return NO;
    }
    uniforms[UNIFORM_MVP] = glGetUniformLocation(program, "mvp");
    uniforms[UNIFORM_Y] = glGetUniformLocation(program, "yTexture");
    uniforms[UNIFORM_U] = glGetUniformLocation(program, "uTexture");
    uniforms[UNIFORM_V] = glGetUniformLocation(program, "vTexture");

    [self setupBuffers];
    return YES;
}


- (void)unloadGL {
    NSLog(@"Cleaning up textures and GL for YUV view");

    [EAGLContext setCurrentContext:self.context];
    [self cleanUpTextures];

    if (program) {
        glDeleteProgram(program);
        program = 0;
    }
}


- (void)cleanUpTextures {
    glDeleteTextures(1, &lumaTexture);
    glDeleteTextures(1, &uChromaTexture);
    glDeleteTextures(1, &vChromaTexture);
}


- (void)cleanup {
    [self update:nil width:0 height:0];
    [self unloadGL];
}


/*
 * PRAGMA MARK: -
 */
- (void)update:(NSData *)pixel
         width:(NSUInteger)width
        height:(NSUInteger)height
{
    _pixel = pixel;
    _width = width;
    _height = height;
    
    dispatch_async(dispatch_get_main_queue(), ^{
        CGFloat aspectRatio = (CGFloat)width / (CGFloat)height;
        if (aspectRatio != self.currentAspectRatio) {
            NSLog(@">>> SETTING ASPECT RATIO ON FRAME UPDATE TO: %@", @(aspectRatio));
            self.currentAspectRatio = aspectRatio;

            // trigger layout flow
            [self setNeedsLayout];
            [self layoutIfNeeded];
        }
        [self setNeedsDisplay];
    });
}


- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    [self postDrawRect];
}


- (void)postDrawRect {
    if (!hasLoadedGL) {
        hasLoadedGL = [self loadGL];

        glUseProgram(program);
        glUniform1i(uniforms[UNIFORM_Y], 0);
        glUniform1i(uniforms[UNIFORM_U], 1);
        glUniform1i(uniforms[UNIFORM_V], 2);

        glActiveTexture(GL_TEXTURE0);
        glGenTextures(1, &lumaTexture);
        glBindTexture(GL_TEXTURE_2D, lumaTexture);
        glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER, GL_LINEAR);
        glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MAG_FILTER, GL_LINEAR);
        glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_WRAP_S, GL_CLAMP_TO_EDGE);
        glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_WRAP_T, GL_CLAMP_TO_EDGE);

        glActiveTexture(GL_TEXTURE1);
        glGenTextures(1, &uChromaTexture);
        glBindTexture(GL_TEXTURE_2D, uChromaTexture);
        glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER, GL_LINEAR);
        glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MAG_FILTER, GL_LINEAR);
        glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_WRAP_S, GL_CLAMP_TO_EDGE);
        glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_WRAP_T, GL_CLAMP_TO_EDGE);


        glActiveTexture(GL_TEXTURE2);
        glGenTextures(1, &vChromaTexture);
        glBindTexture(GL_TEXTURE_2D, vChromaTexture);
        glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER, GL_LINEAR);
        glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MAG_FILTER, GL_LINEAR);
        glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_WRAP_S, GL_CLAMP_TO_EDGE);
        glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_WRAP_T, GL_CLAMP_TO_EDGE);
    }

    GLKMatrix4 mvpMatrix = GLKMatrix4Make(1.0f, 0.0f, 0.0f, 0.0f,
                                          0.0f, 1.0f, 0.0f, 0.0f,
                                          0.0f, 0.0f, 1.0f, 0.0f,
                                          0.0f, 0.0f, 0.0f, 1.0f);
    mvpMatrix = GLKMatrix4Scale(mvpMatrix, 1.0, -1.0, 1.0); // flip image in Y
    mvpMatrix = GLKMatrix4Scale(mvpMatrix, -1.0, 1.0, 1.0); // mirror image in X
    glUniformMatrix4fv(uniforms[UNIFORM_MVP], 1, 0, mvpMatrix.m);

    if (self.pixel) {
        [self render:[self.pixel bytes]
               width:self.width
              height:self.height];
    }
}


- (void)setScaleBehavior:(PSPVideoScaleBehavior)scaleBehavior {
    NSLog(@"Setting scale behavior to: %@", @(scaleBehavior));
    _scaleBehavior = scaleBehavior;

    // need to reposition with a direct frame setter
    super.frame = [self adjustedFrame:_currentFrame];
}


- (void)layoutSubviews {
    [super layoutSubviews];
    super.frame = [self adjustedFrame:self.bounds];
}


- (CGRect)adjustedFrame:(CGRect)frame {
    CGFloat width = roundf(frame.size.width);
    CGFloat height = roundf(frame.size.height);
    if (width <= 0 || height <= 0 || self.currentAspectRatio <= 0) {
        // no need to ratio adjust, plus zero safety checks
        return frame;
    }

    CGFloat frameAspectRatio = width / height;
    if (frameAspectRatio > self.currentAspectRatio) {
        // too wide
        if (_scaleBehavior == PSPVideoScaleBehaviorFit) {
            frame = [self adjustedFrameToHeight:frame];
        } else {
            // default, since there is only fit and fill
            frame = [self adjustedFrameToWidth:frame];
        }
    } else if (frameAspectRatio < self.currentAspectRatio) {
        // too narrow
        if (_scaleBehavior == PSPVideoScaleBehaviorFit) {
            frame = [self adjustedFrameToWidth:frame];
        } else {
            // default, since there is only fit and fill
            frame = [self adjustedFrameToHeight:frame];
        }
    }
    return frame;
}


- (CGRect)adjustedFrameToHeight:(CGRect)frame {
    NSLog(@"Adjusting YUV view frame to height: %@", @(frame));

    CGFloat width = roundf(frame.size.width);
    CGFloat height = roundf(frame.size.height);
    CGFloat newHeight = height;
    CGFloat newWidth = newHeight * self.currentAspectRatio;
    CGFloat diffX = (width - newWidth) * 0.5;
    return CGRectMake(frame.origin.x + diffX, frame.origin.y, newWidth, newHeight);
}


- (CGRect)adjustedFrameToWidth:(CGRect)frame {
    NSLog(@"Adjusting YUV view frame to width: %@", @(frame));

    CGFloat width = roundf(frame.size.width);
    CGFloat height = roundf(frame.size.height);
    CGFloat newWidth = width;
    CGFloat newHeight = newWidth / self.currentAspectRatio;
    CGFloat diffY = (height - newHeight) * 0.5;
    return CGRectMake(frame.origin.x, frame.origin.y + diffY, newWidth, newHeight);
}


-(void)render:(const void*)pixelBuffer
        width:(NSUInteger)width
       height:(NSUInteger)height
{
    gl_width = width & INT_MAX; // reduce to int32
    gl_height = height & INT_MAX;

    // Y-plane
    glActiveTexture(GL_TEXTURE0);
    glBindTexture(GL_TEXTURE_2D, lumaTexture);
    glTexImage2D(GL_TEXTURE_2D,
                 0, // mipmap level of reduction?
                 GL_RED_EXT,
                 gl_width,
                 gl_height,
                 0,
                 GL_RED_EXT,
                 GL_UNSIGNED_BYTE,
                 pixelBuffer);
    // U-Plane
    glActiveTexture(GL_TEXTURE1);
    glBindTexture(GL_TEXTURE_2D, uChromaTexture);
    glTexImage2D(GL_TEXTURE_2D,
                 0,
                 GL_RED_EXT,
                 gl_width/2,
                 gl_height/2,
                 0,
                 GL_RED_EXT,
                 GL_UNSIGNED_BYTE,
                 pixelBuffer + (width * height));
    // V-Plane
    glActiveTexture(GL_TEXTURE2);
    glBindTexture(GL_TEXTURE_2D, vChromaTexture);
    glTexImage2D(GL_TEXTURE_2D,
                 0,
                 GL_RED_EXT,
                 gl_width/2,
                 gl_height/2,
                 0,
                 GL_RED_EXT,
                 GL_UNSIGNED_BYTE,
                 pixelBuffer + (width * height) + ((width/2) * (height/2)));

    // flush it out
    glFlush();

    glDrawElements(GL_TRIANGLE_FAN, 4, GL_UNSIGNED_SHORT, 0);
}

@end


// MetalKit
# pragma mark - MetalKit -
#else

#import <Metal/Metal.h>
#import <MetalKit/MetalKit.h>

#define MTL_STRINGIFY(s) @ #s

/*
 * Metal Shaders
 */
static NSString *const shaderSource = MTL_STRINGIFY(
    using namespace metal;

    typedef struct {
        float4 renderedCoordinate [[position]];
        float2 textureCoordinate;
    } TextureMappingVertex;


    vertex TextureMappingVertex mapTexture(unsigned int vertex_id [[ vertex_id ]])
    {
        float4x4 renderedCoordinates = float4x4(float4( -1.0, -1.0, 1.0, 1.0 ),      /// (x, y, depth, W)
                                                float4(  1.0, -1.0, 1.0, 1.0 ),
                                                float4( -1.0,  1.0, 1.0, 1.0 ),
                                                float4(  1.0,  1.0, 1.0, 1.0 ));

        float4x2 textureCoordinates = float4x2(float2( 1.0, 1.0 ), /// (x, y)
                                               float2( 0.0, 1.0 ),
                                               float2( 1.0, 0.0 ),
                                               float2( 0.0, 0.0 ));
        TextureMappingVertex outVertex;
        outVertex.renderedCoordinate = renderedCoordinates[vertex_id];
        outVertex.textureCoordinate = textureCoordinates[vertex_id];
        return outVertex;
    }


    fragment half4 displayTexture(TextureMappingVertex mappingVertex [[ stage_in ]],
                                  texture2d<uint, access::sample> yTexture [[texture(0)]],
                                  texture2d<uint, access::sample> uTexture [[texture(1)]],
                                  texture2d<uint, access::sample> vTexture [[texture(2)]])
    {
        constexpr sampler s(address::clamp_to_edge, filter::linear);

        float y = yTexture.sample(s, mappingVertex.textureCoordinate).r / 255.0;
        float u = uTexture.sample(s, mappingVertex.textureCoordinate).r / 255.0;
        float v = vTexture.sample(s, mappingVertex.textureCoordinate).r / 255.0;

        u = u-0.5;
        v = v-0.5;

        // old ported conversion:
        //    y = 1.1643*(y-0.0625);
        //    r = y + 1.5958  * v;
        //    g = y - 0.39173 * u - 0.81290 * v;
        //    b = y + 2.017   * u;

        // conversion from http://www.fourcc.org/fccyvrgb.php
        float r = y + 1.403 * v;
        float g = y - 0.344 * u - 0.714 * v;
        float b = y + 1.770 * u;

        float4 out = float4(r, g, b, 1.0);
        return half4(out);
    }
);
static NSString *const vertexFunctionName = @"mapTexture";
static NSString *const fragmentFunctionName = @"displayTexture";


/*
 * PRAGMA MARK: PSPView
 */
@interface PSPView() {
    BOOL hasTextures;

#if TARGET_OS_OSX
    NSRect currentFrame;
#else
    CGRect currentFrame;
#endif
}

@property(nonatomic, strong) NSData* buffer;
@property(nonatomic) NSUInteger width;
@property(nonatomic) NSUInteger height;
@property(nonatomic) CGFloat currentAspectRatio;

@property(nonatomic, strong) id<MTLLibrary> defaultLibrary;
@property(nonatomic, strong) id<MTLCommandQueue> commandQueue;
@property(nonatomic, strong) id<MTLRenderPipelineState> pipelineState;

@property(nonatomic, strong) id<MTLTexture> yTexture;
@property(nonatomic, strong) id<MTLTexture> uTexture;
@property(nonatomic, strong) id<MTLTexture> vTexture;

@end


@implementation PSPView

/*
 * PRAGMA MARK: - Setup/Teardown
 */
- (instancetype)init {
    return [self initWithFrame:CGRectZero];
}


- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self setup];
    }
    return self;
}


#if TARGET_OS_OSX
- (instancetype)initWithFrame:(NSRect)frameRect {
    self = [super initWithFrame:frameRect];
    if (self) {
        [self setup];
    }
    return self;
}
#else
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }
    return self;
}
#endif


- (void)setup {
    NSLog(@"Setting up YUV view...");

    // clipping:
    self.layer.masksToBounds = YES;

    // defaults:
    self.scaleBehavior = PSPVideoScaleBehaviorFill;

    hasTextures = NO;
    currentFrame = self.frame;

    self.device = MTLCreateSystemDefaultDevice();
    NSAssert(self.device, @"Could not tap into MetalKit default device.");

    NSError *error = nil;
    self.defaultLibrary = [self.device newLibraryWithSource:shaderSource
                                                    options:NULL
                                                      error:&error];
    NSAssert(!error, @"Failed to load shader shader library from source with error: %@", error.localizedDescription);

    MTLRenderPipelineDescriptor *rpd = [MTLRenderPipelineDescriptor new];
    rpd.colorAttachments[0].pixelFormat = MTLPixelFormatBGRA8Unorm;
    rpd.depthAttachmentPixelFormat = MTLPixelFormatInvalid;
    rpd.vertexFunction = [self.defaultLibrary newFunctionWithName:vertexFunctionName];
    rpd.fragmentFunction = [self.defaultLibrary newFunctionWithName:fragmentFunctionName];

    self.commandQueue = [self.device newCommandQueue];
    self.pipelineState = [self.device newRenderPipelineStateWithDescriptor:rpd
                                                                     error:&error];
    NSAssert(!error, @"Failed to load shader pipeline with error: %@", error.localizedDescription);
}


- (void)createTextures:(NSUInteger)width height:(NSUInteger)height {
    // Since this will hold a single byte, the pixelFormat is r8Uint
    // Y Texture
    MTLTextureDescriptor *yDesc, *uDesc, *vDesc;
    yDesc = [MTLTextureDescriptor texture2DDescriptorWithPixelFormat:MTLPixelFormatR8Uint
                                                               width:width
                                                              height:height
                                                           mipmapped:false];
    self.yTexture = [self.device newTextureWithDescriptor:yDesc];

    // U and V planes are 2:2 subsampled. That means its size is half on width and height
    // U Texture
    uDesc = [MTLTextureDescriptor texture2DDescriptorWithPixelFormat:MTLPixelFormatR8Uint
                                                               width:width / 2
                                                              height:height / 2
                                                           mipmapped:false];
    self.uTexture = [self.device newTextureWithDescriptor:uDesc];

    // V Texture
    vDesc = [MTLTextureDescriptor texture2DDescriptorWithPixelFormat:MTLPixelFormatR8Uint
                                                               width:width / 2
                                                              height:height / 2
                                                           mipmapped:false];
    self.vTexture = [self.device newTextureWithDescriptor:vDesc];
}


- (void)cleanup {
    [self update:nil
           width:0
          height:0];

    // small delay to flush everything out
    dispatch_async(dispatch_get_main_queue(), ^{
#if TARGET_OS_OSX
        [self setNeedsDisplay:YES];
#else
        [self setNeedsDisplay];
#endif
    });
}


/*
 * PRAGMA MARK: -
 */
- (void)update:(NSData *)buffer
         width:(NSUInteger)width
        height:(NSUInteger)height
{
    _buffer = buffer;
    _width = width;
    _height = height;

    CGFloat aspectRatio = (CGFloat)width / (CGFloat)height;
    if (aspectRatio != self.currentAspectRatio) {
        self.currentAspectRatio = aspectRatio;
    }

    [self render];
}


- (void)setScaleBehavior:(PSPVideoScaleBehavior)scaleBehavior {
    NSLog(@"Setting scale behavior to: %@", @(scaleBehavior));
    _scaleBehavior = scaleBehavior;

    // need to reposition with a direct frame setter
    // (going through an override)
#if TARGET_OS_OSX
    super.frame = NSRectFromCGRect([self adjustedFrame:NSRectToCGRect(currentFrame)]);
#else
    super.frame = [self adjustedFrame:currentFrame];
#endif
}


- (void)setCurrentAspectRatio:(CGFloat)currentAspectRatio {
    NSLog(@"Setting current aspect ratio to: %@", @(currentAspectRatio));
    _currentAspectRatio = currentAspectRatio;

    // need to reposition with a direct frame setter
#if TARGET_OS_OSX
    super.frame = NSRectFromCGRect([self adjustedFrame:NSRectToCGRect(currentFrame)]);
#else
    super.frame = [self adjustedFrame:currentFrame];
#endif
}


#if TARGET_OS_OSX
- (void)setFrame:(NSRect)frame {
    currentFrame = frame;
}
#else
- (void)setFrame:(CGRect)frame {
    currentFrame = frame;
}
#endif


- (void)render {
    @autoreleasepool {
        if (self.buffer) {
            if (!hasTextures) {
                [self createTextures:self.width
                              height:self.height];
                hasTextures = YES;
            }

            [self renderYUV:[self.buffer bytes]
                      width:self.width
                     height:self.height];
        } else {
            [self renderEmpty];
        }
    }
}


- (CGRect)adjustedFrame:(CGRect)frame {
    CGFloat width = roundf(frame.size.width);
    CGFloat height = roundf(frame.size.height);
    if (width <= 0 || height <= 0 || self.currentAspectRatio <= 0) {
        // no need to ratio adjust, plus zero safety checks
        return frame;
    }

    CGFloat frameAspectRatio = width / height;
    if (frameAspectRatio > self.currentAspectRatio) {
        // too wide
        if (_scaleBehavior == PSPVideoScaleBehaviorFit) {
            frame = [self adjustedFrameToHeight:frame];
        } else {
            // default, since there is only fit and fill
            frame = [self adjustedFrameToWidth:frame];
        }
    } else if (frameAspectRatio < self.currentAspectRatio) {
        // too narrow
        if (_scaleBehavior == PSPVideoScaleBehaviorFit) {
            frame = [self adjustedFrameToWidth:frame];
        } else {
            // default, since there is only fit and fill
            frame = [self adjustedFrameToHeight:frame];
        }
    }
    return frame;
}

- (CGRect)adjustedFrameToHeight:(CGRect)frame {
    NSLog(@"Adjusting YUV view frame to height: %@", @(frame));

    CGFloat width = roundf(frame.size.width);
    CGFloat height = roundf(frame.size.height);
    CGFloat newHeight = height;
    CGFloat newWidth = newHeight * self.currentAspectRatio;
    CGFloat diffX = (width - newWidth) * 0.5;
    return CGRectMake(frame.origin.x + diffX, frame.origin.y, newWidth, newHeight);
}

- (CGRect)adjustedFrameToWidth:(CGRect)frame {
    NSLog(@"Adjusting YUV view frame to width: %@", @(frame));

    CGFloat width = roundf(frame.size.width);
    CGFloat height = roundf(frame.size.height);
    CGFloat newWidth = width;
    CGFloat newHeight = newWidth / self.currentAspectRatio;
    CGFloat diffY = (height - newHeight) * 0.5;
    return CGRectMake(frame.origin.x, frame.origin.y + diffY, newWidth, newHeight);
}


- (void)renderYUV:(const void*)buffer
            width:(NSUInteger)width
           height:(NSUInteger)height
{
    [self.yTexture replaceRegion:MTLRegionMake2D(0, 0, width, height)
                     mipmapLevel:0
                       withBytes:buffer
                     bytesPerRow:width];
    [self.uTexture replaceRegion:MTLRegionMake2D(0, 0, width / 2, height / 2)
                     mipmapLevel:0
                       withBytes:buffer + (width * height)
                     bytesPerRow:width / 2];
    [self.vTexture replaceRegion:MTLRegionMake2D(0, 0, width / 2, height / 2)
                     mipmapLevel:0
                       withBytes:buffer + (width * height) + ((width/2) * (height/2))
                     bytesPerRow:width / 2];

    if (self.pipelineState && self.currentRenderPassDescriptor && self.currentDrawable) {
        id <MTLCommandBuffer> buffer = self.commandQueue.commandBuffer;
        id <MTLRenderCommandEncoder> encoder = [buffer renderCommandEncoderWithDescriptor:self.currentRenderPassDescriptor];
        if (buffer && encoder) {
            [encoder pushDebugGroup:@"renderFrame"];
            [encoder setRenderPipelineState:self.pipelineState];
            [encoder setFragmentTexture:self.yTexture atIndex:0];
            [encoder setFragmentTexture:self.uTexture atIndex:1];
            [encoder setFragmentTexture:self.vTexture atIndex:2];
            [encoder drawPrimitives:MTLPrimitiveTypeTriangleStrip
                        vertexStart:0
                        vertexCount:4
                      instanceCount:1];
            [encoder popDebugGroup];
            [encoder endEncoding];

            [buffer presentDrawable:self.currentDrawable];
            [buffer commit];
        }
    }
}


- (void)renderEmpty {
    MTLRenderPassDescriptor *rpd = self.currentRenderPassDescriptor;
    rpd.colorAttachments[0].clearColor = MTLClearColorMake(0, 0, 0.5, 1.0);

    if (self.currentDrawable) {
        id <MTLCommandBuffer> buffer = self.commandQueue.commandBuffer;
        id <MTLRenderCommandEncoder> encoder = [buffer renderCommandEncoderWithDescriptor:rpd];
        if (buffer && encoder) {
            [encoder endEncoding];

            [buffer presentDrawable:self.currentDrawable];
            [buffer commit];
        }
    }
}

@end

#endif
