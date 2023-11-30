extends Node2D

const distance = 1920

var random = RandomNumberGenerator.new()
var player_position : Vector2

@onready var obstacle1 = preload("res://Scenes/obstacles/obstacle1.tscn")
@onready var obstacle2 = preload("res://Scenes/obstacles/obstacle2.tscn")
@onready var obstacle3 = preload("res://Scenes/obstacles/obstacle3.tscn")
@onready var obstacle4 = preload("res://Scenes/obstacles/obstacle4.tscn")
@onready var obstacle5 = preload("res://Scenes/obstacles/obstacle5.tscn")

var o1 : TileMap
var o2 : TileMap
var o3 : TileMap
var last_tilemap : TileMap
var fire_position

func get_fire_position():
	fire_position = int(self.get_parent().get_node("fire").position.x)

func choose_obstacles():
	random.randomize()
	var rnumber = random.randi_range(0,4)
	
	if rnumber == 0:
		return obstacle1.instantiate()
		
	elif rnumber == 1:
		return obstacle2.instantiate()
		
	elif rnumber == 2:
		return obstacle3.instantiate()
		
	elif rnumber == 3:
		return obstacle4.instantiate()
		
	elif rnumber == 4:
		return obstacle5.instantiate()

func get_player_position():
	player_position = get_parent().get_node("frog").position

func ground_replacing():
	if player_position.x > (o1.position.x + distance) and last_tilemap != o3:
		o3.queue_free()
		o3 = choose_obstacles()
		add_child(o3)
		o3.position.x = o2.position.x + distance 
		
		last_tilemap = o3

	if player_position.x > (o2.position.x + distance) and last_tilemap != o1:
		o1.queue_free()
		o1 = choose_obstacles()
		add_child(o1)
		o1.position.x = o3.position.x + distance
		
		last_tilemap = o1

	if player_position.x > (o3.position.x + distance) and last_tilemap != o2:
		o2.queue_free()
		o2 = choose_obstacles()
		add_child(o2)
		o2.position.x = o1.position.x + distance
		
		last_tilemap = o2

func burning_tiles():
	pass
func _ready():
	o1 = choose_obstacles()
	o2 = choose_obstacles()
	o3 = choose_obstacles()
	
	last_tilemap = o3
	
	add_child(o1)
	add_child(o2)
	add_child(o3)
	
	o2.position =  Vector2(distance,0)
	o3.position =  Vector2(distance*2,0)
	
func _process(delta):
	get_player_position()
	ground_replacing()
