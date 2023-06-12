shader_type canvas_item;
// When enabled, desaturate the texture and apply the given alpha value.
//
// Derived from:
// - https://ask.godotengine.org/6172/changing-into-gray-the-colours-of-a-texture

uniform bool disabled = true;
uniform float alpha: hint_range(0.0, 1.0) = 0.55;

const vec3 Y = vec3(0.299, 0.587, 0.114);

void fragment() {
	vec4 result = texture(TEXTURE, UV);
	COLOR = disabled ? result : vec4(vec3(dot(Y, result.rgb)), alpha * result.a);
}
