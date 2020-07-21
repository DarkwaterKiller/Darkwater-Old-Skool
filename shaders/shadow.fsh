#version 120

#include "settings.glsl"
//Credit to June for everything here and down (even if i still can't get it working)
uniform sampler2D lightmap;
uniform sampler2D texture;
uniform sampler2D depthtex0;
uniform sampler2D shadowtex0;
uniform sampler2D shadowcolor0;
uniform mat4 shadowModelView;
uniform mat4 shadowProjection;
uniform mat4 gbufferModelViewInverse;
uniform mat4 gbufferProjectionInverse;

varying vec2 lmcoord;
varying vec2 texcoord;
varying vec4 glcolor;

void main()
{
	vec4 color = texture2D( texture, texcoord ) * glcolor;

	vec4 screenPos = vec4( vec3( texcoord, texture2D( depthtex0, texcoord ).r ) * 2.0 - 1.0, 1.0 );
	vec4 viewPos = gbufferProjectionInverse * screenPos;
	viewPos /= viewPos.w;
	vec4 worldPos = gbufferModelViewInverse * viewPos;

	vec4 shadowPos = shadowModelView * worldPos; // worldPos being world position without camera position added to it
	shadowPos = shadowProjection * shadowPos;
	shadowPos /= shadowPos.w;

	float shadowed = step( shadowPos.z - texture2D( shadowtex0, shadowPos.xy ).r, shadow_bias );
	if( shadowed == 0.0 )
		color = vec4( 0.0, 0.0, 0.0, 1.0 );
	
	gl_FragData[0] = color;
}
