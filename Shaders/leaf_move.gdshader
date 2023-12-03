shader_type canvas_item;

uniform float vertical_amplitude = 20.0; // Amplitude do movimento vertical
uniform float vertical_speed = 2.0; // Velocidade do movimento vertical

uniform float horizontal_amplitude = 30.0; // Amplitude do movimento horizontal
uniform float horizontal_speed = 1.5; // Velocidade do movimento horizontal

void vertex() {
    // Aplica uma oscilação na coordenada Y baseada no tempo
    VERTEX.y += sin(TIME * vertical_speed) * vertical_amplitude;

    // Aplica uma oscilação na coordenada X baseada no tempo
    VERTEX.x += cos(TIME * horizontal_speed) * horizontal_amplitude;
}