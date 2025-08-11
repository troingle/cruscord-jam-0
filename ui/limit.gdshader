shader_type canvas_item;

uniform sampler2D SCREEN_TEXTURE : hint_screen_texture, filter_linear_mipmap;
uniform sampler2D color_ramp; // GradientTexture1D

vec3 tex2D(sampler2D _tex, vec2 _p)
{
	vec3 col = texture(_tex, _p).xyz;
	if (abs(_p.x - 0.5) > 0.5) {
		col = vec3(0.1);
	}
	return col;
}

void fragment() {
	vec2 percent = SCREEN_UV;
	vec3 pixelColor = tex2D(SCREEN_TEXTURE, percent);
	float a = texture(SCREEN_TEXTURE, percent).a;

	// Convert pixel color to grayscale (luminance)
	float pixelGrey = dot(pixelColor, vec3(1.0 / 3.0));

	// Sample the gradient texture based on the grayscale value
	vec3 gradientColor = texture(color_ramp, vec2(pixelGrey, 0.0)).rgb;

	COLOR = vec4(gradientColor, a);
}
