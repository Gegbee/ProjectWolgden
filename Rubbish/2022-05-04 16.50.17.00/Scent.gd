extends Node2D

var player : Entity2D = null


func _ready():
  $Timer.connect("timeout", self, "remove_scent")

func remove_scent():
	player = get_node(player_path)
	if player:
		player.scent_trail.erase(self)
	queue_free()