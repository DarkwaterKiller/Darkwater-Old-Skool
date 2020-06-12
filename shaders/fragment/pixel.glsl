
/**
 * This pixelization code was written by Maple
 * You can check out Maple's Retro Extravaganza here:
 * https://github.com/Lana-chan/maples-retro-extravaganza
 */

vec2 pixelize( vec2 uv, vec2 pixelSize )
{
	vec2 factor = vec2( pixelSize ) / vec2( viewWidth, viewHeight );
	return floor( uv / factor ) * factor;
}

vec2 pixelize( vec2 uv, float pixelSize )
{
	return pixelize( uv, vec2( pixelSize ) );
}
