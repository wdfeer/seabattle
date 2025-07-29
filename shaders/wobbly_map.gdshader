shader_type canvas_item;

uniform vec3 color : source_color;
uniform float lineWidth : hint_range(0.0, 100.0, 0.1);
uniform vec2 size;
uniform sampler2D noise : filter_nearest;
uniform sampler2D noise2 : filter_nearest;
uniform sampler2D fill_map : hint_default_white, filter_nearest;
uniform float edge_fade : hint_range(0.0, 1.0, 0.1);
uniform float wave_speed : hint_range(0.0, 10.0, 0.1);

void fragment() {
    float n = texture(noise, mod(UV - TIME * wave_speed / 21.2, 1.0)).r;
    float n2 = texture(noise2, mod(UV + 14.7 + TIME * wave_speed / 40.3, 1.0)).r;
    float n3 = clamp(0.0, 0.3 + pow(n + (n2 * 0.4), 3.0) * 1.5, 1.0);
    vec2 wobble = (n3 - 0.5) * 0.02 / size;

    vec2 distorted_uv = UV + wobble;

    vec2 grid_pos = distorted_uv * size;
    vec2 cell = floor(grid_pos);
    vec2 cell_uv = fract(grid_pos);

    float filled = texture(fill_map, (cell + 0.5) / size).r;

    float thickness = lineWidth / 100.0;

    float edge_dist = min(min(cell_uv.x, 1.0 - cell_uv.x), min(cell_uv.y, 1.0 - cell_uv.y));

    if (filled < 0.5) {
        if (cell_uv.x > thickness && cell_uv.x < 1.0 - thickness &&
            cell_uv.y > thickness && cell_uv.y < 1.0 - thickness) {
            discard;
        }
        COLOR.rgb = color + vec3(n3);
    } else {
		// FIXME: doesn't actually fill in white inside of the cell
        float blend = smoothstep(0.0, thickness * 2.0, edge_dist);
        vec3 wobble_color = color + vec3(n3);
        COLOR.rgb = vec3(1.0);
    }

    vec2 edge = 1.0 - abs(UV - 0.5) * 2.0;
    float fade = clamp(min(edge.x, edge.y) / edge_fade, 0.0, 1.0);
    COLOR.a = fade * n3;
}
