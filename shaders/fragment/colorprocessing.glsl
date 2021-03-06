#include "../settings.glsl"

uniform int worldTime;
const float PI = 3.141596;

/**
 * Convert an RGB color vetor to an HSV color vector
 * @param An RGB color vector
 * @return An HSV color vector
 */
vec3 rgb2hsv( vec3 color )
{
    float minVal, maxVal, deltaVal,
        red, green, blue,
        hue, saturation, value;

    red = color.x;
    green = color.y;
    blue = color.z;
    
    minVal = min( min( red, green ), blue );
    maxVal = max( max( red, green ), blue );
    value = maxVal;
    deltaVal = maxVal - minVal;

    if( maxVal != 0 )
        saturation = deltaVal / maxVal;
    else
    {
        saturation = 0.0;
        hue = -1.0;
        return vec3( hue, saturation, value );
    }

    if( red == maxVal )
        hue = ( green - blue ) / deltaVal;
    else if( green == maxVal )
        hue = 2 + ( blue - red ) / deltaVal;
    else
        hue = 4 + ( red - green ) / deltaVal;
    hue *= 60;

    if( hue < 0 )
        hue += 360;

    return vec3( hue, saturation, value );
}

/**
 * Convert an HSV color vector to an RGB color vector
 * @param An HSV color vector
 * @return An RGB color vector
 */
vec3 hsv2rgb( vec3 colorHSV )
{
    float hh, p, q, t, ff,
        red, green, blue,
        hue, saturation, value;
    int i;

    hue = colorHSV.x;
    saturation = colorHSV.y;
    value = colorHSV.z;

    if( saturation <= 0.0 )
    {
        red = value;
        green = value;
        blue = value;
        return vec3( red, green, blue );
    }

    hh = hue;
    if( hh >= 360.0 )
        hh = 0.0;
    hh /= 60.0;
    i = int( hh );
    ff = hh - i;
    p = value * ( 1.0 - saturation );
    q = value * ( 1.0 - ( saturation * ff ) );
    t = value * ( 1.0 - ( saturation * ( 1.0 - ff ) ) );

    switch( i )
    {
        case 0:
            red = value;
            green = t;
            blue = p;
            break;
        case 1:
            red = q;
            green = value;
            blue = p;
            break;
        case 2:
            red = p;
            green = value;
            blue = t;
            break;
        case 3:
            red = p;
            green = q;
            blue = value;
            break;
        case 4:
            red = t;
            green = p;
            blue = value;
            break;
        case 5:
        default:
            red = value;
            green = p;
            blue = q;
            break;
    }

    return vec3( red, green, blue );
}



vec3 boostSaturation( vec3 color, float saturation_mult )
{
    vec3 colorHSV = rgb2hsv( color );
    colorHSV.y *= saturation_mult;
    return hsv2rgb( colorHSV );
}

float crushColorValue( float value, float crushDepth )
{
    #if color_grading_function == 1
        value *= value;
    #elif color_grading_function == 2
        value = 1.0 - value;
        value *= value;
        value = 1.0 - value;
    #elif color_grading_function == 3
        float presqr;
        if( value <= 0.5 )
        {
            presqr = ( 1.0 - 2.0 * value );
            value = ( 1.0 - ( presqr * presqr ) ) / 2.0;
        }
        else
        {
            presqr = ( 2.0 * value - 1.0 );
            value = ( ( presqr * presqr ) / 2.0 ) + 0.5;
        }
    #elif color_grading_function == 4
        float invExpVal = 1.0 - ( ( 1.0 - value ) * ( 1.0 - value ) );
        float invExpFactor = 0.0;

        if( worldTime >= 13000 && worldTime <= 23000 )
            invExpFactor = abs( sin( float( PI * ( worldTime - 3000 ) ) / 10000 ) );

        value = ( value * ( 1.0 - invExpFactor ) ) + ( invExpVal * invExpFactor );
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
