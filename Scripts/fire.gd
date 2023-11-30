extends Area2D
var fire_velocity = 250
var fire_velocity_out_of_screen = 350
var game_over_scene = preload("res://Scenes/game_over_screen.tscn")
var game_over = game_over_scene.instantiate()
var x_position : int

func move(delta):
	var frog_position = get_parent().get_node("frog").position.x
	
	if frog_position - self.position.x > 1000:
		self.position.x += fire_velocity_out_of_screen*delta
	
	else:
		self.position.x += fire_velocity*delta
	
	if self.position.x > frog_position + 800:
		fire_velocity = 0
		fire_velocity_out_of_screen = 0
		get_parent().add_child(game_over)

func burned_boost(delta):
	if get_parent().get_node("frog").burned == true:
		fire_velocity = move_toward(fire_velocity,fire_velocity*4,delta*1500)

func _on_body_entered(body):
	if body.name == "frog":
		get_parent().get_node("frog").burned = true
		
	if body.name == "obstacle1":
		print("obstacle1")
	if body.name == "obstacle2":
		print("obstacle2")
	if body.name == "obstacle3":
		print("obstacle3")

func _process(delta):
	move(delta)
	burned_boost(delta)
	

	
