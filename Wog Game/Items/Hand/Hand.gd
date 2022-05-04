extends Item2D

var used : bool = false

func _process(delta):
	var animation = $AnimationPlayer.get_animation("Hitting") # replace with your track name
	var track = animation.find_track("Area2D:position") # or an integer
	animation.track_set_key_value(track, 1, get_local_mouse_position().normalized() * 6)
	animation.track_set_key_value(track, 2, get_local_mouse_position().normalized() * 6)

func use():
	if !used:
		used = true
		$Timer.start(0.5)
		$AnimationPlayer.play("Hitting")
		for body in $Area2D.get_overlapping_bodies():
			if body.is_in_group('entity') and body != parent: 
				body.damage(1)


func _on_Timer_timeout():
	used = false
