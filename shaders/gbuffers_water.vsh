#version 120

#include "settings.glsl"

//Moving entities IDs
//See block.properties for mapped ids
#define entity_water 1.0

varying vec2 lmcoord;
varying vec2 texcoord;
varying vec4 glcolor;

varying vec3 worldPositionVector;

attribute vec4 mc_Entity;

uniform vec3 cameraPosition;
uniform mat4 gbufferModelView;
uniform mat4 gbufferModelViewInverse;

//moving stuff
uniform float frameTimeCounter;
const float PI = 3.14159;

void main()
{
	texcoord = ( gl_TextureMatrix[0] * gl_MultiTexCoord0 ).xy;
	lmcoord  = ( gl_TextureMatrix[1] * gl_MultiTexCoord1 ).xy;
    vec3 position = mat3( gbufferModelViewInverse ) * ( gl_ModelViewMatrix * gl_Vertex ).xyz + gbufferModelViewInverse[3].xyz;
    worldPositionVector = position.xyz + cameraPosition;

    #ifdef water_waves
        if( mc_Entity.x == entity_water )
        {
            float wave = 0.05 * sin( 0.5 * PI * ( frameTimeCounter * animation_speed + worldPositionVector.x / 6.0 + worldPositionVector.z / 10.0 ) )
                        + 0.05 * sin( 0.75 * PI * ( frameTimeCounter * animation_speed + worldPositionVector.z / 2.5 ) );
            position.y += wave * wave_amplitude;
        }
    #endif

     gl_Position = gl_ProjectionMatrix * gbufferModelView * vec4( position, 1.0 );

	glcolor = gl_Color;
}