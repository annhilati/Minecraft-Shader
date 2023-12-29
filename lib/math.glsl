vec4 normalizeRange(vec4 inputColor256) {
    return inputColor256 / 256.0;
}
//Wandelt eine Farbe mit 256 als maximalen Farbkanalwert in eine mit 1 als Maximalwert um 