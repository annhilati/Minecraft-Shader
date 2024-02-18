#version 120
#define COLOR_SOURCE 0 //[0 1 2]
#define POST_EFFECT 0 //[0 1 2]
#define COLORGRADING_EFFECT 0 //[0 1 2 3]
#define COORD_TEST 0 //[0 1 2]
#define COORD_TEST_CIRCLE 0.1 //[0.1 0.15 0.2 0.25 0.3 0.5]

uniform sampler2D colortex0;
uniform sampler2D depthtex0;
uniform sampler2D shadowtex0;

varying vec2 texcoord;
// Importiert die aktuelle Textur und die Kooridinaten des aktuellen Fragments

#include "lib/post/color.glsl"
#include "lib/post/colorgrading.glsl"
#include "lib/post/effects.glsl"
#include "lib/math.glsl"
#include "lib/testing.glsl"

void main() {
    // Farbinitialisierung
    #if COLOR_SOURCE == 0
        vec4 sourcedColor = texture2D(colortex0, texcoord);
    #elif COLOR_SOURCE == 1
        vec4 sourcedColor = texture2D(depthtex0, texcoord);
    #elif COLOR_SOURCE == 2
        vec4 sourcedColor = texture2D(shadowtex0, texcoord);
    #endif
    vec4 FragColor = sourcedColor;

    // POST_EFFECT
    #if POST_EFFECT == 1
        FragColor = simplify(FragColor);
    #elif POST_EFFECT == 2
        FragColor = vikoify(FragColor);
    #endif

    // COLORGRADING_EFFECT
    #if COLORGRADING_EFFECT == 1
        FragColor = grayscale(FragColor);
    #elif COLORGRADING_EFFECT == 2
        FragColor = sepia(FragColor);
    #elif COLORGRADING_EFFECT == 3
        FragColor = invert(FragColor);
    #endif

    // COORD_TEST
    #if COORD_TEST == 1
        //if (sqrt(pow((texcoord.x - 0.2) * 16/9 , 2.0) + pow((texcoord.y - 0.2), 2.0)) <= COORD_TEST_CIRCLE) {
        if (pyDistance(texcoord, vec2(0.2), 16.0/9.0) <= COORD_TEST_CIRCLE) {
            FragColor = vec4(1, 0, 0, 1);
        }
    #elif COORD_TEST == 2
        if (pyDistance(texcoord, vec2(0.2), 16.0/9.0) <= COORD_TEST_CIRCLE) {
            float dst = sqrt(pow((texcoord.x - 0.5) * 16/9 , 2.0) + pow((texcoord.y - 0.5), 2.0));
            FragColor = FragColor * (1 - (dst - COORD_TEST_CIRCLE));
        }
    #endif



    gl_FragColor = FragColor;
}
