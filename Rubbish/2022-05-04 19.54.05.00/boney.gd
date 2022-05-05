extends Entity2D

enum {
	LOOK,
	CHASE,
	FIGHT,
	DEAD
}

var state = LOOK
var dir
export var equip_left : String
export var equip_right : String
export var player_path : NodePath
var player : Entity2D 

func _ready():
	equip_left = 'hand'
	equip_right = 'hand'
	addLeftHandItem(equip_left)
	addRightHandItem(equip_right)

func _process(delta):
	match state:
		LOOK:
			look(delta)
			
		CHASE:
			pass
			
		FIGHT:
			fight(delta)
		
		DEAD:
			pass

func look(delta):
	dir = find_target()
	
	if dir:
		var motion = dir * speed/4
		move_and_slide(motion)
	
func find_target():
	var look = get_node("RayCast2D")
	look.cast_to = (get_parent().get_node('Player').position - position)
	look.force_raycast_update()
	
	if player:
		var length = player.position - position
		if length < 20:
			state = FIGHT
	
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


func fight(delta):
	var look = get_node("RayCast2D")
	look.cast_to = (get_parent().get_node('Player').position - position)
	look.force_raycast_update()
	
	if player:
		var length = player.position - position
		if length > 20:
			state = LOOK
		
	else:
		useLeftHand()

