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
			if get_parent().get_node('Player'):
				$RayCast2D.cast_to
		GAME_STATE.MOVEMENT:
			print('moving')
