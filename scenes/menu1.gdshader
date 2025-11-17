shader_type canvas_item;

uniform float speed : hint_range(0.0,2.0)=0.2;
uniform vec4 symbol_color : source_color = vec4(0.3,0.05,0.05,1.0);
uniform vec4 background_color : source_color = vec4(0.0,0.0,0.0,1.0);

void fragment(){
    vec2 uv = UV*2.0-1.0;
    float r = length(uv);
    float angle = atan(uv.y, uv.x);
    float star = abs(sin(5.0*angle + TIME*speed));
    float mask = smoothstep(0.4,0.45,star) * smoothstep(0.8,0.0,r);
    COLOR = mix(background_color, symbol_color, mask);
}


