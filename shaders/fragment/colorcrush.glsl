#include "../shaders.settings"

float crushColorValue( float value, float crushDepth )
{

    #ifdef exponential_color_levels
        value = 1.0 - value;
        value = pow( value, 2.0 );
        value = 1.0 - value;
    #endif

    float crushMagnitude = 256.0 / pow( 2.0, crushDepth );
    float crushed = float( int( int( value * 255 ) / crushMagnitude ) * crushMagnitude );
    if( crushed > 127.0 )
        crushed += crushMagnitude - 1.0;
    crushed /= 255.0;
    return crushed;
}

vec3 crush( vec3 color, float crushDepth )
{
    float red = crushColorValue( color.x, crushDepth );
    float green = crushColorValue( color.y, crushDepth );
    float blue = crushColorValue( color.z, crushDepth );

    return vec3( red, green, blue );
}
