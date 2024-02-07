extends CanvasLayer

var character_position : Vector2

func _on_restart_button_pressed():
	get_tree().reload_current_scene()
  
func _on_menu_button_pressed():
	get_tree().change_scene_to_file("res://Scenes/menu_scene.tscn")

func _ready():
	$animation.play("GameOver")
	$looseSong.play()

func _physics_process(delta):
	var character = self.get_parent().get_node("frog")
	var color_rect = $grayBlur 
	var shader_material = color_rect.material
	$looseSong.position = character.position
	
	shader_material.set_shader_parameter("character_position_y", character.position.y)
 
