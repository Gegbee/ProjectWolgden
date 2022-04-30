extends Node2D

var type: String
onready var Types = get_node("/root/Types") 

func _ready():
	type = Types.types[0]
	
	#enemy = get_node(Types)
	#var Type = preload(enemy)
func spawn():
	var enemy = Type.instance()
	#add_child(enemy)
	

func _on_Timer_timeout():
	spawn()
