extends Node2D

#enemy list stored in res://Enemies/Types.gd     <= autoloaded
var type = 1

var enemy_type = Types.enemy_dict[type]
var enemy = load(enemy_type)

func spawn():
	var enemy_instance = enemy.instance()
	var child = add_child(enemy_instance)
	child.position = ((self.position.x + rand_range(0, 100), self.position.y + rand_range(0, 100))

func _on_Timer_timeout():
	spawn()
