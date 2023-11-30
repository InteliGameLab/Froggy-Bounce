extends Node2D

var velocity = 0
var force = 0
var height = 0
var target_heght = 0

var index = 0
var motion_factor = 0.02
var collided_with = null
signal splash

@onready var collision = $Area2D/CollisionShape2D

func water_update(spring_constance, dampening):
	
	height = self.position.y
	var x = height - target_heght
	var loss = -dampening * velocity
	
	force = - spring_constance * x + loss
	velocity += force 
	self.position.y += velocity

func initialize(x_position,id):
	height = self.position.y
	target_heght = self.position.y
	velocity = 0
	index = id
	
	self.position.x = x_position

func set_collision_width(value):
	var extents = collision.shape.get_size()
	var new_extents = Vector2(value/2,extents.y)
	collision.shape.set_size(new_extents)


func _on_area_2d_body_entered(body):
	if body == collided_with:
		return
		
	collided_with = body
	
	var speed = body.velocity.y * motion_factor
	emit_signal("splash",index,speed)
