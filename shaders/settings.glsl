#define pixelate                    //Enable/Disable pixelation
#define pixel_size 6				//[0 1 2 3 4 5 6] Chooses the pixel size for pixelization and color dithering
#define color_crushing              //Enable/Disable altering the bit depth of colors
#define depth_val 4                 //[0 1 2 3 4 5 6 7] Chooses the color depth
//#define separate_color_channels   //Enable/Disable separate color depth channels
#define red_depth_val 4             //[0 1 2 3 4 5 6 7] Chooses the color depth of the red channel
#define green_depth_val 4           //[0 1 2 3 4 5 6 7] Chooses the color depth of the green channel
#define blue_depth_val 4            //[0 1 2 3 4 5 6 7] Chooses the color depth of the blue channel
#define exponential_color_levels    //Enable/Disable color intensities being set on an exponential scale
#define saturation_multiplier 1.0   //[0.0 0.1 0.2 0.3 0.4 0.5 0.6 0.7 0.8 0.9 1.0 1.1 1.2 1.3 1.4 1.5 1.6 1.7 1.8 1.9 2.0] Multiplier for color saturation
#define color_grading_function 2    //[0 1 2 3] Linear: Color intensity changes linearly. Exponential: (Dark -> Mid: Slow, Light -> Mid: Fast). Inverted Exponential: (Dark -> Mid: Fast, Light -> Mid: Slow). Piecewise: (Dark -> Mid: Fast, Light -> Mid: Fast)
#define animation_speed 0.5         //[0.25 0.5 0.75 1.0 1.25 1.5 1.75 2.0] Set the animation speed for things like waves
//#define water_waves               //Enable/Disable waves in water
#define wave_amplitude 0.6          //[0.2 0.4 0.6 0.8 1.0 1.2 1.4 1.6 1.8 2.0] The max height of the water waves