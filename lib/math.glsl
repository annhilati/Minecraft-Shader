vec4 normalizeRange(vec4 inputColor256) {
    return inputColor256 / 256.0;
}

float pyDistance(vec2 texcoords, vec2 pointcoords, float screenratio) {
    return sqrt(pow((texcoords.x - pointcoords.x) * screenratio , 2.0) + pow((texcoords.y - pointcoords.y), 2.0));
}
// screenratio muss als Dezimalbruch angegeben werden, wobei die Breite der Zähler und die Höhe der Nenner ist