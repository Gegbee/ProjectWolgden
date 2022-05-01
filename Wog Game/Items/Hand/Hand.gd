extends Item2D

var used : bool = false

func _process(delta):
	var relativePos = global_position - get_global_mouse_position()
	rotation = atan2(relativePos.y, relativePos.x)
	print(scale)
func use():
	if !used:
		used = true
		$Timer.start(0.5)
		$AnimationPlayer.play("Hitting")
		for body in $Area2D.get_overlapping_bodies():
			if body.is_in_group('entity'):
				body.damage(1)


func _on_Timer_timeout():
	used = false
