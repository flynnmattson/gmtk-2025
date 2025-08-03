    shader_type spatial;
	
	uniform sampler2D texture_albedo;
    uniform float shrink_factor = 1.0;

    void fragment() {
		vec2 scaled_uv = UV * shrink_factor; // Scales the texture by a factor of 2, making it appear smaller and repeated
        ALBEDO = texture(texture_albedo, scaled_uv).rgb;
    }