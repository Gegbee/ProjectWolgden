extends Entity2D

enum {
	IDLE
	CHASE,
	FIGHT,
	DAMAGED,
	DEAD
}

var state = CHASE

const SPEED = 2
const FORCE = 0.02
var velocity : Vector2

export var equip_left : String
export var equip_right : String

onready var player_vars = get_node("/root/PlayerVars")
var target : Vector2 
var dir : Vector2

var stun_time : float = 0.2
var timer : float

var cur_health = MAX_HEALTH
var rng = RandomNumberGenerator.new()

func _ready():
	randomize()
	equip_left = 'hand'
	equip_right = 'hand'
	addLeftHandItem(equip_left, self)
	addRightHandItem(equip_right, self)

func _process(delta):
	target = player_vars.position
	
	$PlayerCast.cast_to = player_vars.position - position
	$PlayerCast.force_raycast_update()
	$Label.text = str(state)
	
	match state:
		IDLE:
			pass
			
		CHASE:
			if health >= 0:
				chase()
				setHandDir((player_vars.position - position).normalized())
			
		FIGHT:
			if health >= 0:
				combat(delta)
				setHandDir((player_vars.position - position).normalized())
		
		DAMAGED:
			move(-impulse_vector * 2)
			
			timer += delta
			if timer > stun_time:
				state = FIGHT
				timer = 0
				
		DEAD:
			pass


#func _physics_process(delta):
#	var target = get_global_mouse_position()
#	velocity = steer(target)
#	#move_and_slide(velocity)
#
#	if Input.is_action_just_pressed("left_click"):
#		wander()

func chase():
	move(steer(target))
	
	var player_dist = player_vars.position - position
	if player_dist.length() < 25:
		state = FIGHT
	
	if health < cur_health:
		state = DAMAGED
		cur_health = health
		
	
		
func combat(delta):
	var player_dist = player_vars.position - position
	var decision_time = 0.7
	
	timer += delta
	if timer > decision_time:
		
		if player_dist.length() < 20:
			fight()
		timer = 0


	if player_dist.length() > 15:
		state = CHASE

func fight():
	var decision = rng.randi_range(0,2)
	print(decision)
	if decision == 0:
		stab()
		print('1')
	if decision == 1:
		if player_vars.state != 3:
			block()
			print('2')
	if decision == 2:
		block()
		print('3')

func stab():
	useHand('right')

func block():
	useHand('left')
	
#
#func _on_AttackArea_body_entered(body):
#	if body.is_in_group('player'):
#		if player_vars.state != 'USING_NO_HAND':
#			var randomNumber = randi()%100
#			if randomNumber > 50:
#				block()
#			else:
#				stab()


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


func steer(target : Vector2) -> Vector2:
	var helper = (target - get_position()).normalized() * SPEED 
	var desired_velocity = Vector2(helper.x, helper.y)
	
	var steer = desired_velocity - velocity
	var target_velocity = velocity + (steer * FORCE )
	return target_velocity
	

func move_to(pos : Vector2):
	if position != pos:
		for i in range(10):
			move_and_slide(pos - position)
			#yield(get_tree().create_timer(0.5), "timeout")
			if position == pos:
				break

func look(delta):
	if health <= 0:
		state = DEAD
	
	setHandDir(player_vars.position - position)
	dir = find_target()
	
	if dir:
		var motion = dir * speed/4
		move(motion)
	
func find_target():
	
	var look = get_node("PlayerCast")
	look.cast_to = (player_vars.position - position)
	look.force_raycast_update()
	
	var length = player_vars.position - position
	if length.length() < 15:
		state = FIGHT
	
  # if we can see the target, chase it
	if look.is_colliding() == false:
		dir = look.cast_to.normalized()
		return dir

  # or chase first scent we can see	
	else:
		for scent in player_vars.scent_trail:
			look.cast_to = (scent.position - position)
			look.force_raycast_update()
			if look.is_colliding() == false:
				dir = look.cast_to.normalized()
				return dir
				break


