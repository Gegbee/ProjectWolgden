extends Entity2D

enum {
	IDLE
	CHASE,
	FIGHT,
	DEAD
}

var state = CHASE
var dir
export var equip_left : String
export var equip_right : String

export var player_path : NodePath
var player : Entity2D = null


func init(path):
	player_path = path

func _ready():
	equip_left = 'hand'
	equip_right = 'hand'
	addLeftHandItem(equip_left, self)
	addRightHandItem(equip_right, self)


func _process(delta):
	player = get_node(player_path)
	if player != null:
		match state:
			IDLE:
				pass
			CHASE:
				look(delta)
				
			FIGHT:
				fight(delta)
			
			DEAD:
				pass

func idle():
#	var look = get_node("RayCast2D")
#	look.cast_to = (player.position - position)
#	look.force_raycast_update()
#
#	var length = player.position - position
#	if length.length() < 15:
#		state = FIGHT
#
#  # if we can see the target, chase it
#	if look.is_colliding() == false:
#		dir = look.cast_to.normalized()
#		return dir
	pass

func look(delta):
	if health <= 0:
		state = DEAD
	
	setHandDir(player.position - position)
	dir = find_target()
	
	if dir:
		var motion = dir * speed/4
		move_and_slide(motion)
	
func find_target():
	var look = get_node("RayCast2D")
	look.cast_to = (player.position - position)
	look.force_raycast_update()
	
	var length = player.position - position
	if length.length() < 15:
		state = FIGHT
	
  # if we can see the target, chase it
	if look.is_colliding() == false:
		dir = look.cast_to.normalized()
		return dir

  # or chase first scent we can see	
	else:
		for scent in (get_parent().get_node('Player').scent_trail):
			look.cast_to = (scent.position - position)
			look.force_raycast_update()
			if look.is_colliding() == false:
				dir = look.cast_to.normalized()
				return dir
				break


func fight(delta):
	if health <= 0:
		state = DEAD
	
	
	setHandDir(player.position - position)
	var look = get_node("RayCast2D")
	look.cast_to = (player.position - position)
	look.force_raycast_update()
	
	var length = player.position - position
	item_in_use = false
	if length.length() > 15:
		useHand("left")
		state = CHASE
		
	if length.length() > 10:
		useHand("right")
