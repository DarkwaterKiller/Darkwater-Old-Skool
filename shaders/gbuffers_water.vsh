#version 120

/**
 * Currently, the majority of what's in this file was written by Sildur.
 * So thank you Sildur, you can find their work here:
 * https://sildurs-shaders.github.io/
 */

#include "settings.glsl"


//Moving entities IDs
//See block.properties for mapped ids
#define entity_water    10008.0     //9

varying vec2 lmcoord;
varying vec2 texcoord;
varying vec4 glcolor;

varying vec3 vworldpos;
varying float iswater;
varying float mat;

attribute vec4 mc_Entity;

uniform vec3 cameraPosition;
uniform mat4 gbufferModelView;
uniform mat4 gbufferModelViewInverse;

//moving stuff
uniform float frameTimeCounter;
const float PI = 3.14159;

void main() {
	//gl_Position = ftransform();

    //Positioning
	texcoord = ( gl_TextureMatrix[0] * gl_MultiTexCoord0 ).xy;
	lmcoord  = ( gl_TextureMatrix[1] * gl_MultiTexCoord1 ).xy;
    vec3 position = mat3( gbufferModelViewInverse ) * ( gl_ModelViewMatrix * gl_Vertex ).xyz + gbufferModelViewInverse[3].xyz;

    vworldpos = position.xyz + cameraPosition;

    iswater = 0.0;
    if( mc_Entity.x == entity_water )
    {
        iswater = 0.95; //don't fully remove shadows on water plane
    }

    #ifdef water_waves
        if( mc_Entity.x == entity_water )
        {
            float fy = fract( vworldpos.y + 0.001 );

            float wave = 0.05 * sin( 2 * PI * ( frameTimeCounter * animation_speed + vworldpos.x / 2.5 + vworldpos.z / 5.0 ) )
                        + 0.05 * sin( 2 * PI * ( frameTimeCounter * animation_speed + vworldpos.x / 6.0 + vworldpos.z / 12.0 ) );

            position.y += clamp( wave, -fy, 1.0 - fy ) * wave_amplitude;
        }
    #endif

     gl_Position = gl_ProjectionMatrix * gbufferModelView * vec4( position, 1.0 );

	glcolor = gl_Color;
}