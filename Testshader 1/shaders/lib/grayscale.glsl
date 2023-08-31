vec4 grayscale(vec4 inputColor) {
    float average = (inputColor.r + inputColor.g + inputColor.b) / 3.0;
    return vec4(vec3(average), inputColor.a);
}
/* Definiert die Funktion grayscale(), die den Mittelwert der Farbwerte der Eingangsfarbe ermittelt und
zusammen mit dem Alphawert der Eingabefarbe zurückgibt */