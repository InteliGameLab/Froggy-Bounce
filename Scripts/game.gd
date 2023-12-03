extends Node2D

@onready var calmMusic = $sounds/calmMusic
@onready var intenseMusic = $sounds/intenseMusic
@onready var frog = $frog

func _process(delta):
	if frog.burned == false:
		var frogPosition = get_node("frog").position.x
		var firePosition = get_node("fire").position.x

		# Calcular a distância entre o sapo e o fogo
		var distance = abs(frogPosition - firePosition)

		# Definir a intensidade da música com base na distância
		var intensity = 1.0 - (distance / 2000.0)  # Ajuste isso conforme necessário

		# Limitar a intensidade entre 0 e 1
		intensity = clamp(intensity, 0.0, 1.0)

		# Ajustar o volume das músicas com base na intensidade calculada
		calmMusic.volume_db =  -10 + (20.0 * (1 - intensity))
		intenseMusic.volume_db = -30 + (50.0 * (intensity))
	else:
		calmMusic.volume_db = move_toward(calmMusic.volume_db,0,10)
		intenseMusic.volume_db = move_toward(intenseMusic.volume_db,-30,5)

func _ready():
	intenseMusic.volume_db = -30
