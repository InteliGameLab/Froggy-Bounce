extends Node2D

func _on_texture_button_pressed():
	$startButton/startSound.play()
	await $startButton/startSound.finished
	get_tree().change_scene_to_file("res://Scenes/game.tscn")

func _ready():
	$startScreen/animationStart.play("Logo")
	
	if GlobalScript.already_started == false:
		$studioScreen/studioSong.play()
		$animation.play("intro_studio")
		GlobalScript.already_started = true

func _on_animation_player_animation_finished(anim_name):
	if anim_name == "intro_studio":
		$menuSound.play()
		$animation.play("intro_menu")
		$studioScreen.queue_free()
		
	if $studioScreen and (GlobalScript.already_started == true):
		$studioScreen.queue_free()
	
	
		
