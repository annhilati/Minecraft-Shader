#version 120
#define COLORGRADING_EFFECT 1 //[0 1 2 3 4]
#define COORD_TEST 1 //[0 1 2]
#define COORD_TEST_CIRCLE 0.1 //[0.1 0.15 0.2 0.25 0.3 0.5]

uniform sampler2D colortex0;
varying vec2 texcoord;
// Importiert die aktuelle Textur und die Kooridinaten des aktuellen Fragments

#include "lib/color.glsl"
#include "lib/math.glsl"

void main() {
    vec4 color = texture2D(colortex0, texcoord);
    vec4 FragColor = color;
    // Extrahiert die Farbe des aktuellen Fragments und Definiert FragColor

    // COLORGRADING
    #if COLORGRADING_EFFECT == 1
        FragColor = grayscale(FragColor);
    #elif COLORGRADING_EFFECT == 2
        FragColor = sepia(FragColor);
    #elif COLORGRADING_EFFECT == 3
        FragColor = invert(FragColor);
    #elif COLORGRADING_EFFECT == 4
        FragColor = simplify(FragColor);
    #endif

    // COORD_TEST
    #if COORD_TEST == 1
        if (sqrt(pow((texcoord.x - 0.5) * 16/9 , 2.0) + pow((texcoord.y - 0.5), 2.0)) <= COORD_TEST_CIRCLE) {
            FragColor = normalizeRange(vec4(255, 0, 0, 255));
        }
    #elif COORD_TEST == 2
        if (sqrt(pow((texcoord.x - 0.5) * 16/9 , 2.0) + pow((texcoord.y - 0.5), 2.0)) > COORD_TEST_CIRCLE) {
            float dst = sqrt(pow((texcoord.x - 0.5) * 16/9 , 2.0) + pow((texcoord.y - 0.5), 2.0));
            FragColor = FragColor * (1 - (dst - COORD_TEST_CIRCLE));
        }
    #endif



    gl_FragColor = FragColor;
}
