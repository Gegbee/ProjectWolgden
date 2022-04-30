extends Entity2D


func _physics_process(delta):
	var x = Input.get_action_strength("right")-Input.get_action_strength("left")
	var y = Input.get_action_strength("down")-Input.get_action_strength("up")
	move(Vector2(x, y))
	setHandDir(get_local_mouse_position())
