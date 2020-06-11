#version 120

#include "shaders.settings"

uniform sampler2D gcolor;

varying vec2 texcoord;
uniform float viewWidth, viewHeight;

#include "fragment/pixel.glsl"
#include "fragment/colorcrush.glsl"

const vec2 pixelSizes[ 7 ] = vec2[](
	vec2(1.0),
	vec2(2.0),
	vec2(4.0),
	vec2(8.0),
	vec2(16.0),
	vec2(32.0),
	vec2(64.0)
);

const float colorDepths[ 8 ] = float[](
	8.0,
	7.0,
	6.0,
	5.0,
	4.0,
	3.0,
	2.0,
	1.0
);

void main() {
	vec2 newTC = texcoord;
	vec2 psize = pixelSizes[ pixel_size ];
	float colorDepth = colorDepths[ depth_val ];
	newTC = pixelize( newTC, psize );
	vec3 color = texture2D( gcolor, newTC ).rgb;
	color = crush( color, float( colorDepth ) );
	gl_FragData[ 0 ] = vec4( color, 1.0 );
}