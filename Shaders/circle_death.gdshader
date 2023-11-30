shader_type canvas_item;

uniform vec4 mask_color : source_color = vec4(0, 0, 0, 1.0); // Cor escura da tela
uniform float radius : hint_range(0.0, 2.0) = 0.5; // Define o raio do círculo
uniform float character_position_y ;
const vec4 transparent_color = vec4(0,0,0,0);


void fragment() {
    vec2 center = vec2(0.5,character_position_y/720.0); // Define o centro da tela
    float aspect_ratio = 1.75; // Fator de ajuste do aspect ratio (exemplo)

    // Calcula a distância do ponto atual ao centro
    float distance = distance(center * vec2(aspect_ratio, 1.0), SCREEN_UV * vec2(aspect_ratio, 1.0));

    // Se a distância for menor ou igual ao raio, mantém a cor escura da tela
    if (distance <= radius) {
        COLOR = transparent_color;
    } else {
        // Para pixels fora do círculo, mantém a cor original
        COLOR = mask_color;
    }
}
