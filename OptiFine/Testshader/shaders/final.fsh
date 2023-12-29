#version 120
#define COLORGRADING_EFFECT 1 //[0 1 2]
#define COORD_TEST 1 //[0 1]

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
    #endif

    // ANDERE
    #if COORD_TEST == 1
        if (texcoord.y <= 0.2 && texcoord.y >= 0.19) {
            FragColor = normalizeRange(vec4(255.0, 255.0, 0.0, 255.0));
        }
    #endif



    gl_FragColor = FragColor;
}
