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
#define color_grading_function 0    //[0 1] Linear: Linear color curve. Square Root: Sqrt color curve (Boosts darker colors greatly, but light ones also appear a bit brigher).
#define animation_speed 1.0         //[0.25 0.5 0.75 1.0 1.25 1.5 1.75 2.0] Set the animation speed for things like waves
#define water_waves                 //Enable/Disable waves in water
#define wave_amplitude 0.6          //[0.2 0.4 0.6 0.8 1.0] The max height of the water waves

//#define shadowtex0_overlay        //Enable/Disable shadowtex0 Overlay. DEBUGGING ONLY!

#define shadow_distort_enabled      //Toggles shadow map distortion
#define shadow_distort_factor 0.10  //Distortion factor for the shadow map. Has no effect when shadow distortion is disabled. [0.00 0.01 0.02 0.03 0.04 0.05 0.06 0.07 0.08 0.09 0.10 0.11 0.12 0.13 0.14 0.15 0.16 0.17 0.18 0.19 0.20 0.21 0.22 0.23 0.24 0.25 0.26 0.27 0.28 0.29 0.30 0.31 0.32 0.33 0.34 0.35 0.36 0.37 0.38 0.39 0.40 0.41 0.42 0.43 0.44 0.45 0.46 0.47 0.48 0.49 0.50 0.51 0.52 0.53 0.54 0.55 0.56 0.57 0.58 0.59 0.60 0.61 0.62 0.63 0.64 0.65 0.66 0.67 0.68 0.69 0.70 0.71 0.72 0.73 0.74 0.75 0.76 0.77 0.78 0.79 0.80 0.81 0.82 0.83 0.84 0.85 0.86 0.87 0.88 0.89 0.90 0.91 0.92 0.93 0.94 0.95 0.96 0.97 0.98 0.99 1.00]
#define shadow_bias 0.020           //Increase this if you get shadow acne. Decrease this if you get peter panning. [0.000 0.001 0.002 0.003 0.004 0.005 0.006 0.007 0.008 0.009 0.010 0.012 0.014 0.016 0.018 0.020 0.022 0.024 0.026 0.028 0.030 0.035 0.040 0.045 0.050]
#define exclude_foliage             //If true, foliage will not cast shadows.
#define shadow_brightness 0.75      //Light levels are multiplied by this number when the surface is in shadows [0.00 0.05 0.10 0.15 0.20 0.25 0.30 0.35 0.40 0.45 0.50 0.55 0.60 0.65 0.70 0.75 0.80 0.85 0.90 0.95 1.00]
#define draw_shadow_map gcolor //[gcolor shadowcolor0 shaodwtex0 shadowtex1] Configures which buffer to draw to the screen
#define colored_shadows 1 //0: Stained glass will cast ordinary shadows. 1: Stained glass will cast colored shadows. 2: Stained glass will not cast any shadows. [0 1 2]
