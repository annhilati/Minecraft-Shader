vec4 sepia(vec4 inputColor) {
    float average = (inputColor.r + inputColor.g + inputColor.b) / 3.0;
    return vec4(average + 0.15, average + 0.075, average, inputColor.a);
}

vec4 wdh_cM21(vec4 inputColor) {
    return vec4(log(sqrt(pow(inputColor.r, 2) + pow(inputColor.g, 2) + pow(inputColor.b, 2))), 0.0, 0.0, inputColor.a);
}