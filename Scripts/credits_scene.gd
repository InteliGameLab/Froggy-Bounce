extends Node2D


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$frog.rotation_degrees += 3


func _on_texture_button_pressed():
	get_tree().change_scene_to_file("res://Scenes/menu_scene.tscn")
