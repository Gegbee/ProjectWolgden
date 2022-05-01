extends Item2D

var used : bool = false

func use():
	if !used:
		used = true
		$Timer.start(0.6)
		for body in get_overlapping_bodies():
			if body.is_in_group('entity'):
				body.damage(2)


func _on_Timer_timeout():
	used = false
