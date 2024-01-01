vec4 grayscale(vec4 inputColor) {
    float average = (inputColor.r + inputColor.g + inputColor.b) / 3.0;
    return vec4(vec3(average), inputColor.a);
}

vec4 sepia(vec4 inputColor) {
    float average = (inputColor.r + inputColor.g + inputColor.b) / 3.0;
    return vec4(average + 0.15, average + 0.075, average, inputColor.a);
}

vec4 invert(vec4 inputColor) {
    return vec4(1 - inputColor);
}

vec4 simplify(vec4 inputColor) {
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

vec4 vikoify(vec4 inputColor) {
    float brightness = grayscale(inputColor).r;
    if (brightness <= 1.0/6.0) {
        float value = 6.0 * brightness;
        return vec4(0.0, 0.0, value, 1.0);
    } else if (brightness <= 2.0/6.0) {
        float value = 6.0 * (brightness - 1.0/6.0);
        return vec4(0.0, value, 1.0, 1.0);
    } else if (brightness <= 3.0/6.0) {
        float value = 1.0 - (6.0 * (brightness - 2.0/6.0));
        return vec4(0.0, 1.0, value, 1.0);
    } else if (brightness <= 4.0/6.0) {
        float value = (6.0 * (brightness - 3.0/6.0));
        return vec4(value, 1.0, 0.0, 1.0);
    } else if (brightness <= 5.0/6.0) {
        float value = 1.0 - (6.0 * (brightness - 4.0/6.0));
        return vec4(1.0, value, 0.0, 1.0);
    } else if (brightness <= 1) {
        float value = (6.0 * (brightness - 5.0/6.0));
        return vec4(1.0, value, value, 1.0);
    }
    return vec4(brightness);
}