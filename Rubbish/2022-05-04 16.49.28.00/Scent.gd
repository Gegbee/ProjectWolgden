extends Node2D

export var player_path : NodePath

func _ready():
  $Timer.connect("timeout", self, "remove_scent")

func remove_scent():
  player.scent_trail.erase(self)
  queue_free()