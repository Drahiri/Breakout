shader_type canvas_item;

uniform sampler2D screen_texture: hint_screen_texture, repeat_enable;

void vertex() {
	float strength = 0.3;
	UV = vec2(UV.x + sin(TIME) * strength, UV.y + cos(TIME) * strength);
}

const float edge_kernel[9] = {
	-1.0, -1.0, -1.0,
	-1.0,  8.0, -1.0,
	-1.0, -1.0, -1.0
 };

const float offset = 1.0f / 300.0f;
const vec2 offsets[9] = {
	vec2( -offset,  offset ), // top-left
	vec2(    0.0f,  offset ), // top-center
	vec2(  offset,  offset ), // top-right
	vec2( -offset,    0.0f ), // center-left
	vec2(    0.0f,    0.0f ), // center-center
	vec2(  offset,    0.0f ), // center-right
	vec2( -offset, -offset ), // bottom-left
	vec2(    0.0f, -offset ), // bottom-center
	vec2(  offset, -offset )  // bottom-right
};

void fragment() {
	vec3 sample[9];

	for(int i = 0; i < 9; ++i){
		sample[i] = texture(screen_texture, UV + offsets[i]).rgb;
	}

	for(int i = 0; i < 9; ++i)
	{
		COLOR += vec4(sample[i] * edge_kernel[i], 0.0f);
	}
	COLOR.a = 1.0f;
}