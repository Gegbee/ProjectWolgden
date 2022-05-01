extends "res://Entity2D/Entity2D.gd"

enum GAME_STATE {DETECTION, MOVEMENT}

# currentstate
var currentGameState = GAME_STATE.DETECTION

func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	match currentGameState:
		GAME_STATE.DETECTION:
			var player = get_parent().get_node('Player')
			if player:
				$RayCast2D.cast_to(player.position)
				
					
		GAME_STATE.MOVEMENT:
			print('moving')
