extends Node2D

var type: String
onready var Types = get_node("/root/Types") 

func _ready():
	type = Types.enemy_dict.Enemy
	
	enemy = get_node(type)
	var enemy_type = preload(enemy)
func spawn():
	var enemy = enemy.instance()
	add_child(enemy)
	

func _on_Timer_timeout():
	spawn()
