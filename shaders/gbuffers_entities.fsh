#version 120

#include "lib/utils.glsl"

const int GL_LINEAR = 9729;
const int GL_EXP = 2048;

uniform sampler2D lightmap;
uniform sampler2D texture;
uniform int fogMode;
uniform vec4 entityColor;

varying vec2 lmcoord;
varying vec2 texcoord;
varying vec4 glcolor;
varying vec3 vNormal;

void main()
{
    vec4 color = texture2D( texture, texcoord ) * glcolor;
    vec4 lightColor = texture2D( lightmap, lmcoord );
    color *= lightColor;

    vec3 light1 = vec3( 0.1, 0.6, 0.2 );
    vec3 light2 = vec3( -0.1, 0.0, -0.2 );
    color.rgb *= ( ( clamp( dot( vNormal, light1 ), 0.0, 1.0 ) + clamp( dot( vNormal, light2 ), 0.0, 1.0 ) * 0.6 ) + 0.4 );

    color.rgb += entityColor.rgb;
    if( max3( color.rgb ) > 1.0 )
    {
        color.rgb /= max3( color.rgb );
    }

    /* DRAWBUFFERS:0 */
    gl_FragData[0] = color; //gcolor

    gl_FragData[1] = vec4( vec3( gl_FragCoord.z ), 1.0 );

    if( fogMode == GL_EXP )
    {
        gl_FragData[0].rgb = mix( gl_FragData[0].rgb, gl_Fog.color.rgb, 1.0 - clamp( exp( -gl_Fog.density * gl_FogFragCoord ), 0.0, 1.0 ) );
    }
    else if( fogMode == GL_LINEAR )
    {
        gl_FragData[0].rgb = mix( gl_FragData[0].rgb, gl_Fog.color.rgb, clamp( ( gl_FogFragCoord - gl_Fog.start ) * gl_Fog.scale, 0.0, 1.0 ) );
    }
}
