#version 120

#include "distort.glsl"
#include "settings.glsl"

//Moving entities IDs
//See block.properties for mapped ids
#define entity_lily_pad     2.0
#define entity_lava         3.0
#define entity_foliage      4.0

varying vec2 lmcoord;
varying vec2 texcoord;
varying vec4 glcolor;
varying vec3 worldPositionVector;
varying vec4 shadowPos;

attribute vec4 mc_Entity;

uniform vec3 cameraPosition;
uniform mat4 gbufferModelView;
uniform mat4 gbufferModelViewInverse;
uniform mat4 shadowModelView;
uniform mat4 shadowProjection;
uniform vec3 shadowLightPosition;

//moving stuff
uniform float frameTimeCounter;
const float PI = 3.14159;

void main()
{
    //Positioning
	texcoord = ( gl_TextureMatrix[0] * gl_MultiTexCoord0 ).xy;
	lmcoord  = ( gl_TextureMatrix[1] * gl_MultiTexCoord1 ).xy;
    vec3 position = mat3( gbufferModelViewInverse ) * ( gl_ModelViewMatrix * gl_Vertex ).xyz + gbufferModelViewInverse[3].xyz;
    worldPositionVector = position.xyz + cameraPosition;
    
    float lightDot = dot( normalize( shadowLightPosition ), normalize( gl_NormalMatrix * gl_Normal ) );
    vec4 viewPos = gl_ModelViewMatrix * gl_Vertex;


    #ifdef water_waves
        if( mc_Entity.x == entity_lily_pad )
        {
            float wave = 0.05 * sin( 2 * PI * ( frameTimeCounter * 0.8 + worldPositionVector.x /  2.5 + worldPositionVector.z / 5.0 ) )
				   + 0.05 * sin( 2 * PI * ( frameTimeCounter * 0.6 + worldPositionVector.x / 6.0 + worldPositionVector.z /  12.0 ) );
            position.y += wave * wave_amplitude;
        }

        if( mc_Entity.x == entity_lava )
        {
            float wave = 0.05 * sin( 0.5 * PI * ( frameTimeCounter * 0.8 + worldPositionVector.x /  2.5 + worldPositionVector.z / 5.0 ) )
				   + 0.05 * sin( 0.5 * PI * ( frameTimeCounter * 0.6 + worldPositionVector.x / 6.0 + worldPositionVector.z /  12.0 ) );
            position.y += wave * wave_amplitude;
        }
    #endif

    //disable shadows for things like grass by setting the light location to right above the object
    #ifdef exclude_foliage
        if( mc_Entity.x == entity_foliage )
            lightDot = 1.0;
    #endif

    //vertex is facing toward the sun
    if( lightDot > 0.0 )
    {
        vec4 playerPos = gbufferModelViewInverse * viewPos;
        //convert to shadow screen space
        shadowPos = shadowProjection * ( shadowModelView * playerPos );
        float distortFactor = getDistortFactor( shadowPos.xy );
        //apply shadow distortion
        shadowPos.xyz = distort( shadowPos.xyz, distortFactor );
        //convert from [-1,1] to [0,1]
        shadowPos.xyz = shadowPos.xyz * 0.5 + 0.5;
        shadowPos.z -= shadow_bias * ( distortFactor * distortFactor ) / abs( lightDot );
    }
    else
    {
        //always in shadow, reduce light level
        lmcoord.y *= shadow_brightness;
        //mark that shadow does not need to be checked by shadow map
        shadowPos = vec4( 0.0 );
    }
    shadowPos.w = lightDot;
    //gl_Position = gl_ProjectionMatrix * gbufferModelView * vec4( position, 1.0 );
    gl_Position = gl_ProjectionMatrix * viewPos;
	glcolor = gl_Color;
}