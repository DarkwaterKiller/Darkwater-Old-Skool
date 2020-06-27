#version 120

varying vec2 texcoord;
uniform sampler2D colortex0;
uniform float viewWidth, viewHeight;

uniform sampler2D depthtex0;

#include "lib/utils.glsl"

void main() {
	vec2 newTC = texcoord;
	vec3 color;
	

	if(newTC.x < 0.0 || newTC.x > 1.0 || newTC.y < 0.0 || newTC.y > 1.0)
		color = vec3(0.0, 0.0, 0.0);
	else
		color = texture2D(colortex0, newTC).rgb;

	gl_FragData[0] = vec4(color, 1.0);
}