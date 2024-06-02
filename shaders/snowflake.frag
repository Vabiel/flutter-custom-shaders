// original shader https://www.shadertoy.com/view/XlSBz1

precision highp float;

#include <flutter/runtime_effect.glsl>

uniform float iTime;
uniform vec2 iResolution;
uniform vec4 backgroundColor;
uniform vec4 snowflakeColor;

#define PI2 6.28
#define PI 3.1416

vec2 p_to_pc(vec2 p){
return vec2(atan(p.y, p.x), length(p));
}

vec2 pc_to_p(vec2 pc){
return vec2(pc.y * cos(pc.x), pc.y * sin(pc.x));
}

vec2 fieldA(vec2 pc){
pc.y += 0.02 * floor(cos(pc.x * 6.0) * 5.0);
pc.y += 0.01 * floor(10.0 * cos(pc.x * 30.0));
pc.y += 0.5 * cos(pc.y * 10.0);
return pc;
}

vec2 fieldB(vec2 pc, float f){
pc.y += 0.1 * cos(pc.y * 100.0 + 10.0);
pc.y += 0.1 * cos(pc.y * 20.0 + f);
pc.y += 0.04 * cos(pc.y * 10.0 + 10.0);
return pc;
}

vec4 snow_flake(vec2 p, float f){
vec4 col = vec4(0.0);
vec2 pc = p_to_pc(p * 10.0);
pc = fieldA(fieldB(pc, f));
p = pc_to_p(pc);
float d = length(p);
if(d < 0.3){
col.rgba += snowflakeColor;
}
return col;
}

vec4 snow(vec2 p){
vec4 col = vec4(0.0);
p.y -= 2.0 * (iTime / 2.0);  // Изменено направление анимации
p = fract(p + 0.5) - 0.5;
p *= 1.0;
p.x += 0.01 * cos(p.y * 3.0 + p.x * 3.0 + (iTime / 2.0) * PI2);
col += snow_flake(p, 1.0);
col += snow_flake(p + vec2(0.2, -0.1), 4.0);
col += snow_flake(p * 2.0 + vec2(-0.4, -0.5), 5.0);
col += snow_flake(p * 1.0 + vec2(-0.2, 0.4), 9.0);
col += 2.0 * snow_flake(p * 1.0 + vec2(0.4, -0.4), 5.0);
col += snow_flake(p * 1.0 + vec2(-1.2, 1.2), 9.0);
col += snow_flake(p * 1.0 + vec2(2.4, -1.2), 5.0);
col += snow_flake(p * 1.0 + vec2(-1.2, 1.1), 9.0);
return col;
}

layout(location = 0) out vec4 fragColor;

void main(void){
    vec2 fragCoord = FlutterFragCoord();
    vec2 uv = fragCoord.xy / iResolution.x;
    float x = uv.x;
    float y = uv.y;
    vec2 p = vec2(x, y) - vec2(0.5);
    vec4 col = backgroundColor;
    col += 0.3 * snow(p * 2.0);
    col += 0.2 * snow(p * 4.0 + vec2((iTime / 2.0), 0.0));
    col += 0.1 * snow(p * 8.0);
    col.a = 1.0;
    fragColor = col;
}
