extends KinematicBody2D
#extends "res://Entity2D/Entity2D.gd"

enum GAME_STATE {DETECTION, MOVEMENT}

# currentstate
var currentGameState = GAME_STATE.DETECTION
var target

func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	match currentGameState:
		GAME_STATE.DETECTION:
			var player = get_parent().get_node('Player')
			if player:
				$RayCast2D.cast_to = player.position
				if $RayCast2D.is_colliding():
					currentGameState = GAME_STATE.MOVEMENT
					var target = player.position
				
					
		GAME_STATE.MOVEMENT:
			print('moving')
			if target:
				var velocity = global_position.direction_to(target.global_position)
				move_and_collide(velocity * 90 * delta)
			