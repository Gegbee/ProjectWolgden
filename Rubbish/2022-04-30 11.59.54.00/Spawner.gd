extends Node2D

var type: String
onready var enemies = get_node("/root/Enemies/Types.gd")


func _ready():
	type = enemies.types[0]


func spawn():
	pass
	

func _on_Timer_timeout():
	spawn()
