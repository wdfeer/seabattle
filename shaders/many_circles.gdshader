shader_type canvas_item;

uniform float circle_size = 64; // circle radius, 0-1440
uniform vec2 circle_centers[99]; // circle position on the canvas, 0-1440
uniform int circle_count = 0; // Number of circles in the array.

float circle(vec2 position, float radius) {
    float distance = length(position);
    return step(distance, radius);
}

void fragment() {
    float result = 0.0;
    for (int i = 0; i < circle_count; i++) {
		vec2 uvpos = circle_centers[i] / 1440.0;
        vec2 offset = UV - uvpos;
        result = max(result, circle(offset, circle_size / 1440.0));
    }
    COLOR.rgb = vec3(result);
    COLOR.a = result; // Optional: to make circles transparent.
}
