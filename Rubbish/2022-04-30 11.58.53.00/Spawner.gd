extends Node2D

onready var types = get_node("/root/Enemies/Types.gd")


func _ready():
	types.


func spawn():
	pass
	

func _on_Timer_timeout():
	spawn()
