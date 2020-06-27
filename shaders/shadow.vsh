#version 120

attribute vec4 mc_Entity;

varying vec2 lmcoord;
varying vec2 texcoord;
varying vec4 glcolor;

#include "settings.glsl"
#include "distort.glsl"

#define entity_foliage 4.0

void main()
{
    texcoord = ( gl_TextureMatrix[0] * gl_MultiTexCoord0 ).xy;
    lmcoord = ( gl_TextureMatrix[1] * gl_MultiTexCoord1 ).xy;
    glcolor = gl_Color;

    #ifdef exclude_foliage
        if( mc_Entity.x == entity_foliage )
        {
            gl_Position = vec4( 10.0 );
        }
        else
        {
    #endif

            gl_Position = ftransform();
            gl_Position.xyz = distort( gl_Position.xyz );

    #ifdef exclude_foliage
        }
    #endif
}