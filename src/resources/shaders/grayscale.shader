// Derived from:
// - https://godotengine.org/qa/6172/changing-into-gray-the-colours-of-a-texture
// - https://github.com/godotengine/godot-demo-projects/blob/master/2d/screen_space_shaders/shaders/sepia.shader

shader_type canvas_item;

const vec3 Y = vec3(0.299, 0.587, 0.114);
uniform bool disabled = true;
uniform float alpha: hint_range(0.0, 1.0) = 0.55;

void fragment () {
	vec4 tex = texture(TEXTURE, UV);

	if (!disabled) {
			tex.rgb = vec3(dot(tex.rgb, Y));
			tex.a *= alpha;
	}

	COLOR = tex;
}
