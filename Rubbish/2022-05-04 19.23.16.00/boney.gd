extends Entity2D

enum {
	LOOK,
	CHASE,
	FIGHT
}

var state = LOOK
var dir 


func _process(delta):
	match state:
		LOOK:
			look(delta)
			
		CHASE:
			pass
			
		FIGHT:
			pass
			

func look(delta):
	dir = chase_target()
	
	if dir:
		var motion = dir * speed
		move_and_slide(motion)
	
func chase_target():
	var look = get_node("RayCast2D")
	look.cast_to = (get_parent().get_node('Player').position - position)
	look.force_raycast_update()

  # if we can see the target, chase it
	if !look.is_colliding():
		dir = look.cast_to.normalized()
		return dir

  # or chase first scent we can see	
	else:
		for scent in get_parent().get_node('Player').scent_trail:
			look.cast_to = (scent.position - position)
			look.force_raycast_update()
			if !look.is_colliding():
				dir = look.cast_to.normalized()
				return dir
				break

