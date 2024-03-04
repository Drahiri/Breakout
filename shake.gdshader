shader_type canvas_item;

uniform sampler2D screen_texture: hint_screen_texture;

const float blur_kernel[9] = {
        1.0f / 16.0f, 2.0f / 16.0f, 1.0f / 16.0f,
        2.0f / 16.0f, 4.0f / 16.0f, 2.0f / 16.0f,
        1.0f / 16.0f, 2.0f / 16.0f, 1.0f / 16.0f
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

void vertex() {
	float strength = 0.01;
	VERTEX.x += cos(TIME * 10.0) * strength;
	VERTEX.y += cos(TIME * 10.0) * strength;
}

void fragment() {
	vec3 sample[9];
	for(int i = 0; i < 9; ++i)
        {
            sample[i] = texture(screen_texture, SCREEN_UV.st + offsets[i]).rgb;
        }

	for(int i = 0; i < 9; ++i) {
		COLOR += vec4(sample[i] * blur_kernel[i], 0.0f);
	}
	COLOR.a = 1.0;
}