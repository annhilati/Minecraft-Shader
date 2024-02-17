vec4 effect_simplify(vec4 inputColor) {
    // Alle sind gleich
    if (inputColor.r == inputColor.g && inputColor.r == inputColor.b) {
        if (inputColor.r > 0.5) {
            return vec4(1.0);
        } else {
            return vec4(0.0);
        }
    // Zwei sind gleich
    } else if (inputColor.r == inputColor.g) {
        return vec4(1.0, 1.0, 0.0, 1.0);
    } else if (inputColor.r == inputColor.b) {
        return vec4(1.0, 0.0, 1.0, 1.0);
    } else if (inputColor.g == inputColor.b) {
        return vec4(0.0, 1.0, 1.0, 1.0);
    // Einer ist am größten
    } if (inputColor.r > inputColor.g && inputColor.r > inputColor.b) {
        return vec4(1.0, 0.0, 0.0, 1.0);
    } else if (inputColor.g > inputColor.r && inputColor.g > inputColor.b) {
        return vec4(0.0, 1.0, 0.0, 1.0);
    } else {
        return vec4(0.0, 0.0, 1.0, 1.0);
    }
}

vec4 effect_thermal(vec4 inputColor) {
    float luminosity = luminosity(inputColor);
    if (luminosity <= 1.0/4.0) {
        float value = 4.0 * (luminosity);
        return vec4(0.0, value, 1.0, 1.0);
    } else if (luminosity <= 2.0/4.0) {
        float value = 1.0 - (4.0 * (luminosity - 1.0/4.0));
        return vec4(0.0, 1.0, value, 1.0);
    } else if (luminosity <= 3.0/4.0) {
        float value = (4.0 * (luminosity - 2.0/4.0));
        return vec4(value, 1.0, 0.0, 1.0);
    } else if (luminosity <= 4.0/4.0) {
        float value = 1.0 - (4.0 * (luminosity - 3.0/4.0));
        return vec4(1.0, value, 0.0, 1.0);
    }
    return vec4(luminosity);
}