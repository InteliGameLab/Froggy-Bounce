extends CharacterBody2D

const jump_velocity = -600.0
const aceleration = 500
const max_speed = 400
const friction = 250

var current_animation = "walking"
var air_jumps = 1
var power = 0
var burned = false
var playing = false

var burning_shader = preload("res://Shaders/burning.tres")

func movement(delta):
	if burned == false:
		jump(delta)
		air_jump()
		move(delta)
	
		move_and_slide()
	else:
		play_song("burned")
		self.z_index = 300

func jump(delta):
	var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
	
	if not is_on_floor():
		velocity.y += gravity * delta
		velocity.x = move_toward(velocity.x,0,friction*delta*0.3)

	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		play_song("jump")
		if power < 0.5:
			velocity.y = jump_velocity / 1.3
			velocity.x += 100
		else:
			velocity.y = jump_velocity * power
			velocity.x += 100
	
func air_jump():
	if is_on_floor():
		air_jumps = 1
		
	if Input.is_action_just_pressed("ui_accept") and (not is_on_floor()) and (air_jumps == 1):
		play_song("jump")
		velocity.y = jump_velocity
		velocity.x += 150
		air_jumps = 0

func move(delta):
	power = abs(velocity.x/max_speed)
		
	if is_on_floor():
		velocity.x = move_toward(velocity.x,max_speed,aceleration*delta)
		velocity.x = clamp(velocity.x,0,max_speed)
		current_animation = "walking"
		
	if not is_on_floor():
		current_animation = "jump"

func play_animation():
	if current_animation == "walking" and burned == false:
		if velocity.x < 30:
			$animation.play("stand")
		else:
			$animation.play("walking")
			$animation.speed_scale = (velocity.x / max_speed) * 1
	
	elif current_animation == "jump" and burned == false:
		if velocity.y < -30:
			$animation.play("jump")
		elif velocity.y > 30:
			$animation.play("fall")
		else:
			$animation.play("air stand")
	
	elif burned == true and playing == false:
		$sprite.material = burning_shader
		$sprite/spriteAnimation.play("burning")
		playing = true

func play_song(song):
	if song == "bunerd":
		$sons/burned.play()
	elif song == "jump":
		$sons/jump.play()

func _physics_process(delta):
	movement(delta)
	play_animation()
			
func _ready():
	$sprite.modulate = Color(1,1,1,1)
	$sprite.material = null
	self.z_index = 0
	playing = false
