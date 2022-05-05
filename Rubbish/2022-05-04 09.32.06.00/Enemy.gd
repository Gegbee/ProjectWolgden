#extends KinematicBody2D
extends Entity2D

enum state {running,
idle,
dead
detecting
attacking
}

# CHARLIE (ALL CAPS JUST SO YOU NOTICE THIS, IM NOT MAD), YOU CAN NOT GET PLAYER THIS WAY IT DONT WORKY
# ALSO ORGANIZE YOU CODE GOD UFKCING DAMNIT, DONT MAKE SUBPROCESS FUNCTIONS INSIDE OF PROCESS AND PHYSICS PROCESS JUST SEPARATE THEM BY LARGE SPACES
#greg ur a chode FUCK YOU CHARLIE YOU FACKIN CUNT

export var player_path : NodePath
var player : Entity2D = null
var enemy_state = state.running
export var left : String
export var right : String


func _ready():
	addLeftHandItem(left, self)
	addRightHandItem(right, self)
	enter_state(state.detecting)
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
	if(enemy_state == state.idle):
		idle()
		
	if(enemy_state == state.detecting):
		detecting()
		$Label.set_text('detecting')
	if(enemy_state == state.running):
		running()
		$Label.set_text('running')
	if(enemy_state == state.attacking):
		combat()
		$Label.set_text('attacking')
	if(enemy_state == state.dead):
		dead()
		$Label.set_text('dead')
	pass

func leave_state(pass_state):
	pass
	


func idle():
	pass
	#enemy sleeping/dozing animation here, randomly wakes up every few seconds, then runs detection, if he detects player then its fisticuffs time (he wont stop chasing player unless he cant see them)
	
func detecting():
	var space_state = get_world_2d().direct_space_state
	var result = space_state.intersect_ray(global_position, player.global_position, [self])
	if result:
		var body = $PlayerCast.get_collider()
		if body != null:
			if body.is_in_group('player'):
				print(body)
				enter_state(state.running)
	

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
#	else:
#		enter_state(state.detecting)

			
func combat():
	var length = player.global_position - global_position
	#print(str(length.length()))
	if length.length() > 20:
		enter_state(state.running)
	useLeftHand()

func dead():
	pass
