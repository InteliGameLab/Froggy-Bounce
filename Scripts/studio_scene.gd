extends Node2D
func _ready():
	$AnimationPlayer.play("intro")

func _on_animation_player_animation_finished(anim_name):
	if anim_name == "intro":
		self.queue_free()
