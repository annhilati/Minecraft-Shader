#version 120

#define COLORGRADING_EFFECT 1.0 //[0.0, 1.0]
// Definiert COLORGRADING_EFFECT und beschränkt mögliche Werte auf 0 und 1
#include "lib/grayscale.glsl"
// Inkludiert die Graustufen Funktion

uniform sampler2D sampler0;
varying vec2 texcoord;
// Importiert die aktuelle Textur und die Kooridinaten des aktuellen Fragments

void main() {
    vec4 color = texture2D(sampler0, texcoord);
    vec4 FragColor
    // Extrahiert die Farbe des aktuellen Fragments und Definiert FragColor

    #if COLORGRADING_EFFECT == 1
        FragColor = grayscale(color);
    #else
        FragColor = color;
    #endif
    /*  Berechnet grayscale von color, wenn COLORGRADING_EFFECT gleich 1 ist.
    Sonst übergibt er der Ausgabevariable die Ursprungsfarbe des aktuellen Fragments */
    gl_FragColor = FragColor;
}