extends Node2D

var type = 'Enemy'

var enemy_type = Types.enemy_dict[type]
var enemy = load(enemy_type)

func spawn():
	var enemy_instance = enemy.instance()
	add_child(enemy_instance)

func _on_Timer_timeout():
	spawn()
