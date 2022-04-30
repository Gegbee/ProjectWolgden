extends Node2D

onready var types = get_node("/root/Enemies/Types.gd")


func _ready():
	pass # Replace with function body.


func spawn():
	pass
	

func _on_Timer_timeout():
	spawn()
