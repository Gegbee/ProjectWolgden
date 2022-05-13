extends Node2D

var hallway_type : String
var room_types = []
# Called when the node enters the scene tree for the first time.
func _ready():
	$Player.position = Vector2(5, 488)
	
	hallway_type = $World.path_to_map
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
