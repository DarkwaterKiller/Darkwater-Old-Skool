#version 120

varying vec2 lmcoord;
varying vec2 texcoord;
varying vec4 glcolor;
varying vec3 vNormal;

uniform mat4 gbufferModelView;
uniform mat4 gbufferModelViewInverse;

//this is taken from some older shader
//i'll add more comments when I understand what's happening
//god help me
void main()
{
    //positioning
    texcoord = ( gl_TextureMatrix[0] * gl_MultiTexCoord0 ).xy;
    lmcoord = ( gl_TextureMatrix[1] * gl_MultiTexCoord1 ).xy;
    vec3 normal = gl_NormalMatrix * gl_Normal;
    vec3 position = mat3( gbufferModelViewInverse ) * ( gl_ModelViewMatrix * gl_Vertex ).xyz + gbufferModelViewInverse[3].xyz;

    vNormal = normalize( vec3( vec4( normal, 0.0 ) * transpose( gbufferModelViewInverse ) ) );

    gl_Position = gl_ProjectionMatrix * gbufferModelView * vec4( position, 1.0 );
    glcolor = gl_Color;
}
