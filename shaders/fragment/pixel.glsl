
//Pixelization stuffs, don't ask me how. It just works.

vec2 pixelize( vec2 uv, vec2 pixelSize )
{
	vec2 factor = vec2( pixelSize ) / vec2( viewWidth, viewHeight );
	return floor( uv / factor ) * factor;
}

vec2 pixelize( vec2 uv, float pixelSize )
{
	return pixelize( uv, vec2( pixelSize ) );
}
