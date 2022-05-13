extends Node2D


var rng = RandomNumberGenerator.new()

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

func start(x, y):
	position = Vector2(x, y)
	

func _on_Area2D_body_entered(body):
	if body.is_in_group('player'):
		get_tree().change_scene('res://Main/Room.tscn')


func room_gen():
	var map_texture = Image.new()
	#var map = textures[randi() % textures.size()]
	var tile_num = rng.randi_range(0, 3)
	
	var path_to_map = 'res://Pixelart/Maps/rooms/tile00' + str(tile_num) + '.png'
	
	map_texture.load(path_to_map)
	print(path_to_map)
	map_texture.lock()
	for row in map_texture.get_height():
		for column in map_texture.get_width():
			#print(image.get_pixel(column, row))
			if map_texture.get_pixel(column, row) == ColorN("white"):
				$TileMap.set_cell(column, row, 0)
			if map_texture.get_pixel(column, row) == ColorN("blue"):
				$TileMap.set_cell(column, row, 1)

					
	map_texture.unlock()