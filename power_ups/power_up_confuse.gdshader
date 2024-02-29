shader_type canvas_item;

uniform sampler2D screen_texture: hint_screen_texture;

void vertex() {
	UV = vec2(1.0 - UV.x, 1.0 - UV.y);
}

void fragment() {
	COLOR = vec4(1.0 - texture(screen_texture, UV).rgb, 1.0);
}
