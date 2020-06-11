#version 120

#include "shaders.settings"

uniform sampler2D gcolor;

varying vec2 texcoord;
uniform float viewWidth, viewHeight;

#include "fragment/pixel.glsl"
#include "fragment/colorcrush.glsl"

const vec2 pixelSizes[ 6 ] = vec2[](
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

	#ifdef pixelate
		vec2 psize = pixelSizes[ pixel_size ];
		newTC = pixelize( newTC, psize );
	#endif
	vec3 color = texture2D( gcolor, newTC ).rgb;

	#ifdef color_crushing
		#ifndef separate_color_channels
			float colorDepth = colorDepths[ depth_val ];
			color = crush( color, float( colorDepth ) );
		#else
			float redColorDepth = colorDepths[ red_depth_val ];
			float greenColorDepth = colorDepths[ green_depth_val ];
			float blueColorDepth = colorDepths[ blue_depth_val ];
			color.x = crushColorValue( color.x, float( redColorDepth ) );
			color.y = crushColorValue( color.y, float( greenColorDepth ) );
			color.z = crushColorValue( color.z, float( blueColorDepth ) );
		#endif
	#endif
	
	gl_FragData[ 0 ] = vec4( color, 1.0 );
}