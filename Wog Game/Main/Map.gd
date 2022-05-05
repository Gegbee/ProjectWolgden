extends TileMap
class_name AStar_Path

onready var astar = AStar.new()
onready var used_cells = get_used_cells()

var path : PoolVector2Array

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
