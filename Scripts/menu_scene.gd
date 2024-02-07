extends Node2D
var buttonPressed = false

func _on_texture_button_pressed():
	if buttonPressed == false:
		buttonPressed = true
		$startButton/startSound.play()
		await $startButton/startSound.finished
		get_tree().change_scene_to_file("res://Scenes/game.tscn")
	else:
		pass
		
func _on_credit_button_pressed():
	if buttonPressed == false:
		buttonPressed = true
		$creditButton/startSound.play()
		await $creditButton/startSound.finished
		get_tree().change_scene_to_file("res://Scenes/credits_scene.tscn")
		
func _ready():
	$startScreen/animationStart.play("Logo")
	
	if GlobalScript.already_started == false:
		$studioScreen/studioSong.play()
		$animation.play("intro_studio")
		GlobalScript.already_started = true
	else:
		$studioScreen.queue_free()

func _on_animation_player_animation_finished(anim_name):
	if anim_name == "intro_studio":
		$menuSound.play()
		$animation.play("intro_menu")
		$studioScreen.queue_free()
		
	if $studioScreen and (GlobalScript.already_started == true):
		$studioScreen.queue_free()

