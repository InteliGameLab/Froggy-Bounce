extends CanvasLayer

func get_points():
	var points = get_parent().get_node("frog").position.x/100
	$Label.text = str(int(points)).pad_zeros(5) + " M"
	
func _process(delta):
	get_points()
