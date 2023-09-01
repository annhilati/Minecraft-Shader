#version 120
#define COLORGRADING_EFFECT 1 //[0 1]
// Definiert COLORGRADING_EFFECT und beschränkt mögliche Werte auf 0 und 1

vec4 grayscale(vec4 inputColor) {
    float average = (inputColor.r + inputColor.g + inputColor.b) / 3.0;
    return vec4(vec3(average), inputColor.a);
}
// Definiert die Graustufen Funktion

uniform sampler2D colortex0;
varying vec2 texcoord;
// Importiert die aktuelle Textur und die Kooridinaten des aktuellen Fragments

void main() {
    vec4 color = texture2D(colortex0, texcoord);
    vec4 FragColor;
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