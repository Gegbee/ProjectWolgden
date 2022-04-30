extends Node2D

var type: String
onready var Types = get_node("/root/Types") 

func _ready():
	type = Types.types[0]
	print(type)
	
func spawn():
	pass
	

func _on_Timer_timeout():
	spawn()
