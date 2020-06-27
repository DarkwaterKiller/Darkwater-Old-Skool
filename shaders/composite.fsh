#version 120

#include "settings.glsl"

uniform float frameTimeCounter;
uniform sampler2D gcolor;
uniform sampler2D shadowcolor0;
uniform sampler2D shadowtex0;
uniform sampler2D shadowtex1;

varying vec2 texcoord;

void main()
{
    vec3 color = texture2D( draw_shadow_map, texcoord ).rgb;

    /* DRAWBUFFERS:0 */
    gl_FragData[0] = vec4( color, 1.0 ); //gcolor;
}
