
uniform float near;
uniform float far;

float max3( vec3 v )
{
  return max( max( v.x, v.y ), v.z );
}

float clamp01( float v )
{
	return clamp( v, 0.0, 1.0 );
}

float ld( float depth )
{
  return ( 2.0 * near ) / ( far + near - depth * ( far - near ) );
}

vec3 levels( vec3 color, float brightness, float contrast, vec3 gamma )
{
	vec3 value = ( color - 0.5 ) * contrast + 0.5;
	value = clamp( value + brightness, 0.0, 1.0 );
	return clamp( vec3( pow( abs( value.r ), gamma.x ), pow( abs( value.g ), gamma.y ),pow( abs( value.b ), gamma.z ) ), 0.0, 1.0 );
}
vec3 levels( vec3 color, float brightness, float contrast, float gamma )
{ 
	return levels( color, brightness, contrast, vec3( gamma ) );
}