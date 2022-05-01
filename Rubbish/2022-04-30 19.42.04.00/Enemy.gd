extends "res://Entity2D/Entity2D.gd"

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
				$RayCast2D.cast_to(player.position)
				if $RayCast2D.is_colliding() and ($RayCast2D.length() < 50):
					currentGameState = GAME_STATE.MOVEMENT
					var target = player.position
				
					
		GAME_STATE.MOVEMENT:
			print('moving')
			
