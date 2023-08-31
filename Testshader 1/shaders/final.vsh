#version 120

uniform mat4 projectionMatrix;
uniform mat4 modelViewMatrix;
attribute vec4 position;
attribute vec2 uv;
varying vec2 texcoord;

void main() {
    gl_Position = projectionMatrix * modelViewMatrix * position;
    texcoord = uv;
}