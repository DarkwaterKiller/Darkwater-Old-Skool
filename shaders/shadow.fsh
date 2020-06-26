#version 120

uniform sampler2D lightmap;
uniform sampler2D texture;

varying vec2 lmcoord;
varying vec2 texcoord;
varying vec4 glcolor;

void main()
{
	vec4 color = texture2D( texture, texcoord ) * glcolor;

    vec4 lightColor = texture2D( lightmap, lmcoord );

	color *= lightColor;

	/* DRAWBUFFERS:0 */
	gl_FragData[0] = color; //gcolor
}