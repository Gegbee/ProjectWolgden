#extends KinematicBody2D
extends "res://Entity2D/Entity2D.gd"

#enum GAME_STATE {DETECTION, MOVEMENT}
#
## currentstate
#var currentGameState = GAME_STATE.DETECTION
#var target
#
#func _ready():
#	pass # Replace with function body.
#
## Called every frame. 'delta' is the elapsed time since the previous frame.
#func _physics_process(delta):
#	match currentGameState:
#		GAME_STATE.DETECTION:
#			var player = get_parent().get_node('Player')
#			if player:
#				$RayCast2D.cast_to = player.position
#				if $RayCast2D.is_colliding():
#					var n = $RayCast2D.get_collider()
#					if n.is_in_group("player"):
#						currentGameState = GAME_STATE.MOVEMENT
#						target = true
#				else:
#					target = false
##				if $RayCast2D.is_colliding():
#
##					currentGameState = GAME_STATE.MOVEMENT
#
#
#
#		GAME_STATE.MOVEMENT:
#			var player = get_parent().get_node('Player')
#			#print(target)
#			if $RayCast2D.is_colliding():
#				var n = $RayCast2D.get_collider()
#				print(n)
#				if n.is_in_group("player"):
#					currentGameState = GAME_STATE.MOVEMENT
#					target = true
#				else:
#					target = false
#
#			if target:
#				var direction = (player.global_position - global_position).normalized()
#				move_and_slide(direction * 500 * delta)
#
#
#			else:
#				currentGameState = GAME_STATE.DETECTION

#onready var ground_ray = $ground_ray
#onready var wall_ray = $wall_ray

#

enum state {running,
idle,
attacking
}


# CHARLIE (ALL CAPS JUST SO YOU NOTICE THIS, IM NOT MAD), YOU CAN NOT GET PLAYER THIS WAY IT DONT WORKY
# ALSO ORGANIZE YOU CODE GOD UFKCING DAMNIT, DONT MAKE SUBPROCESS FUNCTIONS INSIDE OF PROCESS AND PHYSICS PROCESS JUST SEPARATE THEM BY LARGE SPACES
#var player = preload("res://Player/Player.tscn").instance()
export var player_path : NodePath
var player : Entity2D = null
var enemy_state = state.running

func _ready():
	enter_state(state.running)
	pass 
	
func _physics_process(delta):
	# ENEMY SHOULD DO NOTHING IF PLAYER IS NOT IN SCENE BECAUSE THERE WILL BE NO CAMERA ANYWAYS; AKA: PLAYER IS ALWAYS IN SCENE
	player = get_node(player_path)
	if player:
		$PlayerCast.cast_to = player.global_position - global_position
		process_states()
	pass
	
func enter_state(pass_state):
	if(enemy_state != pass_state):
		leave_state(enemy_state)
		enemy_state = pass_state
		
	if(pass_state == state.running):
		#play("run")
		print('run')
		#$Timer.start(rand_range(0.5,1.5))
		
	if(pass_state == state.idle):
		if(rand_range(0,2) > 1):
			print('anim1')
			#play("idleclean")
		else:
			print('anim2')
			#play("idlestand")

func process_states():
	if(enemy_state == state.attacking):
		attacking()
	if(enemy_state == state.running):
		running()
	pass

func leave_state(pass_state):
	pass
	

func running():
	if $PlayerCast.is_colliding():
		var space_state = get_world_2d().direct_space_state
		var result = space_state.intersect_ray(global_position, player.global_position, [self])
		if result:
			var length = player.global_position - global_position
			length.normalized()
			move_and_slide(length * 50)

			#indent these
			print('player_pos = ' + length)
			if length.length() < 50:
				enter_state(state.attacking)
	else:
		move_and_slide(Vector2(-1, 0) * 50)
		print('no colliders?')
			
func attacking():
	var length = player.global_position - global_position
	if length.length() < 50:
		enter_state(state.running)

#func process_running():
#	if(!ground_ray.is_colliding()):
#		enter_state(state.falling)
#
#	if(wall_ray.is_colliding()):
#		scale.x *= -1
#
#	global_position.x += move_speed * scale.x
#	pass
#
#func process_falling():
#	current_fall_speed = lerp(current_fall_speed,max_fall_speed,0.04)
#	global_position.x += move_speed_fall * scale.x
#	global_position.y += current_fall_speed
#
#	if(ground_ray.is_colliding()):
#		global_position = ground_ray.get_collision_point()
#		enter_state(state.running)
#	pass
#
#func _on_Timer_timeout():
#	if(ground_ray.is_colliding()):
#		enter_state(state.idle)
#	pass # Replace with function body.
#
#func _on_rat_animation_finished():
#	if(animation == "idleclean" or animation == "idlestand"):
#		enter_state(state.running)
#	pass # Replace with function body.

#ignore
#	var player = get_parent().get_node('Player')
#	var direction = (player.global_position - global_position).normalized()
#	move_and_slide(direction * 1500 * delta)
