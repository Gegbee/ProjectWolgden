extends Item2D

var used : bool = false



func use():
	if !used:
		rotation = PI/3 * sin(get_parent().position.normalized().x)
		scale.y = ((1 - 0.2) * abs(sin(get_parent().position.normalized().x)) + 0.2)
		used = true
		$Timer.start(0.5)
		for body in $Area2D.get_overlapping_bodies():
			if body.is_in_group('entity') and not #body.is_in_group('player'):
				body.damage(2)

func _on_Timer_timeout():
	rotation = 0
	scale.y = 1
	used = false
