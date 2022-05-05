extends Entity2D

enum {
	LOOK,
	CHASE,
	FIGHT
}

var state = LOOK



func _process(delta):
	match state:
		LOOK:
			pass
			
		CHASE:
			pass
			
		FIGHT:
			pass