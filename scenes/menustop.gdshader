shader_type canvas_item;

uniform vec4 line_color : source_color = vec4(0.2, 0.2, 0.2, 0.7); // Gris oscuro, transparente
uniform float speed : hint_range(0.0, 0.01) = 0.009;                // Muy lento
uniform float spacing : hint_range(0.01, 0.05) = 0.10;               // Distancia entre grupos de líneas
uniform float line_thickness : hint_range(0.01, 0.05) = 0.02;        // Grosor de cada línea
uniform float line_gap : hint_range(0.005, 0.03) = 0.01;             // Separación entre líneas del mismo grupo
uniform float noise_intensity : hint_range(0.0, 0.02) = 0.07;       // Ruido sutil tipo cinta
uniform float background_alpha : hint_range(0.0, 0.5) = 0.9;      // Transparencia del fondo negro

float rand(float x){
    return fract(sin(x*12.9898)*43758.5453);
}

void fragment() {
    vec2 uv = UV;

    // Fondo negro translúcido
    vec4 bg = vec4(0.0, 0.0, 0.0, background_alpha);

    // Movimiento vertical invertido: de arriba hacia abajo
    float y_moved = fract(uv.y - TIME * speed);

    float alpha = 0.0;

    // Creamos 3–4 líneas juntas en cada grupo
    for (int i = 0; i < 4; i++) {
        float line_pos = fract((y_moved + float(i) * line_gap) / spacing);
        float line_alpha = smoothstep(line_thickness, 0.0, abs(line_pos - 0.5));
        alpha += line_alpha;
    }

    // Ruido sutil tipo cinta
    float noise = (rand(uv.x*100.0 + uv.y*1000.0 + TIME*0.05) - 0.5) * noise_intensity;
    alpha += noise;

    // Mezclamos líneas con fondo negro translúcido
    COLOR = vec4(line_color.rgb, clamp(alpha, 0.0, 1.0) * line_color.a) + bg;
}
