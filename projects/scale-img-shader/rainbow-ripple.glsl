#pragma language glsl3

extern float time;

vec3 hsv2rgb(float h, float s, float v) {
    vec3 c = vec3(h, s, v);
    vec4 k = vec4(1.0, 2.0 / 3.0, 1.0 / 3.0, 3.0);
    vec3 p = abs(fract(c.xxx + k.xyz) * 6.0 - k.www);
    return c.z * mix(k.xxx, clamp(p - k.xxx, 0.0, 1.0), c.y);
}

vec2 ripple(vec2 uv, float time) {
    float dist = length(uv - 0.5);
    float angle = atan(uv.y - 0.5, uv.x - 0.5);
    float wave = sin(dist * 20.0 - time * 5.0) * 0.03;
    return uv + vec2(cos(angle), sin(angle)) * wave;
}

vec4 effect(vec4 color, Image texture, vec2 uv, vec2 screen_coords) {
    uv = ripple(uv, time);
    float hue = fract(uv.x + time * 0.1);
    vec3 col = hsv2rgb(hue, 1.0, 1.0);

    vec4 texColor = texture2D(texture, uv);
    vec4 rainbowColor = vec4(col, 0.5);

    return mix(texColor, rainbowColor, 0.5);
}
