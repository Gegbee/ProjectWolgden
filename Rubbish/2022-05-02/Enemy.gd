extends KinematicBody2D
#extends "res://Entity2D/Entity2D.gd"

enum GAME_STATE {DETECTION, MOVEMENT}

# currentstate
var currentGameState = GAME_STATE.DETECTION
var target

func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	match currentGameState:
		GAME_STATE.DETECTION:
			var player = get_parent().get_node('Player')
			if player:
				$RayCast2D.cast_to = player.position
				if $RayCast2D.is_colliding():
					var n = $RayCast2D.get_collider()
					if n.is_in_group("player"):
						currentGameState = GAME_STATE.MOVEMENT
						target = true
				else:
					target = false
#				if $RayCast2D.is_colliding():
	
#					currentGameState = GAME_STATE.MOVEMENT



		GAME_STATE.MOVEMENT:
			var player = get_parent().get_node('Player')
			#print(target)
			if $RayCast2D.is_colliding():
				var n = $RayCast2D.get_collider()
				print(n)
				if n.is_in_group("player"):
					currentGameState = GAME_STATE.MOVEMENT
					target = true
				else:
					target = false
			
			if target:
				var direction = (player.global_position - global_position).normalized()
				move_and_slide(direction * 500 * delta)
			
			
			else:
				currentGameState = GAME_STATE.DETECTION



#ignore
#	var player = get_parent().get_node('Player')
#	var direction = (player.global_position - global_position).normalized()
#	move_and_slide(direction * 1500 * delta)
