#extends KinematicBody2D
extends Entity2D

enum state {running,
idle,
dead
attacking
}

# CHARLIE (ALL CAPS JUST SO YOU NOTICE THIS, IM NOT MAD), YOU CAN NOT GET PLAYER THIS WAY IT DONT WORKY
# ALSO ORGANIZE YOU CODE GOD UFKCING DAMNIT, DONT MAKE SUBPROCESS FUNCTIONS INSIDE OF PROCESS AND PHYSICS PROCESS JUST SEPARATE THEM BY LARGE SPACES
#greg ur a chode FUCK YOU CHARLIE YOU FACKIN CUNT

export var player_path : NodePath
var player : Entity2D = null
var enemy_state = state.running

func _ready():
	addLeftHandItem("hand", self)
	addRightHandItem("hand", self)
	enter_state(state.running)
	pass 
	
func _physics_process(delta):
	# ENEMY SHOULD DO NOTHING IF PLAYER IS NOT IN SCENE BECAUSE THERE WILL BE NO CAMERA ANYWAYS; AKA: PLAYER IS ALWAYS IN SCENE
	player = get_node(player_path)
	if player:
		$PlayerCast.cast_to = player.global_position - global_position
		process_states()
		if health <= 0:
			enter_state(state.dead)
		if health > 0:
			setHandDir(player.global_position - global_position)
	pass
	
func enter_state(pass_state):
	if(enemy_state != pass_state):
		leave_state(enemy_state)
		enemy_state = pass_state
		
	if(pass_state == state.running):
		#play("run")
		pass
		#$Timer.start(rand_range(0.5,1.5))
		
	if(pass_state == state.idle):
		if(rand_range(0,2) > 1):
			pass
		else:
			pass

func process_states():
	if(enemy_state == state.attacking):
		combat()
	if(enemy_state == state.running):
		running()
	if(enemy_state == state.dead):
		dead()
	pass

func leave_state(pass_state):
	pass
	

func running():
#	if $PlayerCast.is_colliding():
	var space_state = get_world_2d().direct_space_state
	var result = space_state.intersect_ray(global_position, player.global_position, [self])
	if result:
		var length = player.global_position - global_position
		length.normalized()
		move_and_slide(length)

		#indent these
		#print('player_pos = ' + str(length))
		if length.length() < 20:
			enter_state(state.attacking)
		
	else:
		#move_and_slide(Vector2(-1, 0) * 50)
		pass
			
func combat():
	var length = player.global_position - global_position
	#print(str(length.length()))
	if length.length() > 20:
		enter_state(state.running)
	useLeftHand()

func dead():
	pass
