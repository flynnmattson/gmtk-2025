shader_type spatial;

uniform sampler2D texture_albedo; // Your scrolling texture
uniform vec2 scroll_speed = vec2(0.1, 0.0); // Adjust x and y scrolling speeds

void fragment() {
    vec2 scrolled_uv = UV + TIME * scroll_speed; // Shift UVs over time

    ALBEDO = texture(texture_albedo, scrolled_uv).rgb; // Apply scrolled UVs to the texture
}