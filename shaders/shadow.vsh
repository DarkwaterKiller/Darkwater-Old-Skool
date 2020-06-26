#version 120

varying vec2 texcoord;
varying vec2 lmcoord;
varying vec4 gcolor;

uniform mat4 gbufferModelView;
uniform mat4 gbufferModelViewInverse;

void main()
{
    texcoord = ( gl_TextureMatrix[0] * gl_MultiTexCoord0 ).xy;
    lmcoord = ( gl_TextureMatrix[1] * gl_MultiTexCoord1 ).xy;

    gcolor = gl_Color;
}
