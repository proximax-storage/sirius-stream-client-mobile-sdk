//
//  YUVShader.metal
//  PSPClient
//
//  Created by Bastek on 4/29/19.
//  Copyright © 2019 PeerStream, Inc. All rights reserved.
//

#include <metal_stdlib>
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

    float y, u, v, r, g, b;

    y = yTexture.sample(s, mappingVertex.textureCoordinate).r / 255.0;
    u = uTexture.sample(s, mappingVertex.textureCoordinate).r / 255.0;
    v = vTexture.sample(s, mappingVertex.textureCoordinate).r / 255.0;

    u = u-0.5;
    v = v-0.5;

    // old ported conversion:
//    y = 1.1643*(y-0.0625);
//    r = y + 1.5958  * v;
//    g = y - 0.39173 * u - 0.81290 * v;
//    b = y + 2.017   * u;

    // conversion from http://www.fourcc.org/fccyvrgb.php
    r = y + 1.403 * v;
    g = y - 0.344 * u - 0.714 * v;
    b = y + 1.770 * u;

    float4 out = float4(r, g, b, 1.0);
    return half4(out);
}


//kernel void YUVColorConversion(texture2d<uint, access::read> yTexture [[texture(0)]],
//                               texture2d<uint, access::read> uTexture [[texture(1)]],
//                               texture2d<uint, access::read> vTexture [[texture(2)]],
//                               texture2d<float, access::write> outTexture [[texture(3)]],
//                               uint2 gid [[thread_position_in_grid]])
//{
//    float3 colorOffset = float3(0, -0.5, -0.5);
//    float3x3 colorMatrix = float3x3(
//                                    float3(1, 1, 1),
//                                    float3(0, -0.344, 1.770),
//                                    float3(1.403, -0.714, 0)
//                                    );
//
//    uint2 uvCoords = uint2(gid.x / 2, gid.y / 2);
//
//    float y = yTexture.read(gid).r / 255.0;
//    float u = uTexture.read(uvCoords).r / 255.0;
//    float v = vTexture.read(uvCoords).r / 255.0;
//
//    float3 yuv = float3(y, u, v);
//
//    float3 rgb = colorMatrix * (yuv + colorOffset);
//
//    outTexture.write(float4(float3(rgb), 1.0), gid);
//}
