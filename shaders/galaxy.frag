// original shader https://www.shadertoy.com/view/fsGXWG

precision highp float;

#include <flutter/runtime_effect.glsl>

uniform float iTime;
uniform vec2 iResolution;

layout(location = 0) out vec4 fragColor;

void main(void) {
    vec2 fragCoord = FlutterFragCoord();
	vec2 uv = (fragCoord.xy / iResolution.xy) - 0.5;
	float len = length(uv.xy);

    float t = 0.01 * iTime;
	float time = t + (5.0 + sin(t)) * 0.11 / (len + 0.07); // spiraling
	float si = sin(time), co = cos(time);
	uv *= mat2(co, si, -si, co); // rotation

	float c = 0.0, v1 = 0.0, v2 = 0.0, v3;
	vec3 p;

	for (int i = 0; i < 100; i++) {
		p = 0.035 * float(i) * vec3(uv, 1.0);
		p += vec3(0.22, 0.3, -1.5 - sin(t * 1.3) * 0.1);

		for (int j = 0; j < 8; j++) // IFS
			p = abs(p) / dot(p, p) - 0.659;

		float p2 = dot(p, p) * 0.0015;
		v1 += p2 * (1.8 + sin(len * 13.0 + 0.5 - t * 2.0));
		v2 += p2 * (1.5 + sin(len * 13.5 + 2.2 - t * 3.0));
	}

	c = length(p.xy) * 0.175;
	v1 *= smoothstep(0.7, 0.0, len);
	v2 *= smoothstep(0.6, 0.0, len);
	v3 = smoothstep(0.15, 0.0, len);

	vec3 col = vec3(c, (v1 + c) * 0.25, v2);
	col = col + v3 * 0.9;
	fragColor = vec4(col, 1.0);
}
