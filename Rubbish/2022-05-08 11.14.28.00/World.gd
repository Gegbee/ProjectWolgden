extends Node2D

onready var gate = preload('res://Main/Gate .tscn')

var rng = RandomNumberGenerator.new()

func _ready():
	rng.randomize()
	hallway_gen()


func _process(delta):
	var mouse_pos = get_global_mouse_position()
	if mouse_pos != null:
		$Sprite.position = mouse_pos
		$Label.set_text(str(mouse_pos))
		$Label2.set_text(str(mouse_pos/16))


func hallway_gen():
	var map_texture = Image.new()
	#var map = textures[randi() % textures.size()]
	var tile_num = rng.randi_range(0, 3)
	
	var path_to_map = 'res://Pixelart/Maps/testmap/tile00' + str(tile_num) + '.png'
	
	map_texture.load(path_to_map)
	
	map_texture.lock()
	for row in map_texture.get_height():
		for column in map_texture.get_width():
			#print(image.get_pixel(column, row))
			if map_texture.get_pixel(column, row) == ColorN("white"):
				$TileMap.set_cell(column, row, 0)
			if map_texture.get_pixel(column, row) == ColorN("red"):
				$TileMap.set_cell(column, row, 1)
				print('red')
				if map_texture.get_pixel(column + 1, row) == ColorN('red'):
					print('door at: x: ', str(column) , ' y: ' + str(row))
					var gate_instance = gate.instance()
					add_child(gate_instance)
					gate_instance.start(column*16,row*16)
#				if image.get_pixel(column - 1, row) == ColorN('red'):
#					print('door at: x: ', str(column) , ' y: ' + str(row))  
#					var gate_instance = gate.instance()
#					add_child(gate_instance)
#					gate_instance.start(column*16,row*16)
				if map_texture.get_pixel(column, row + 1) == ColorN('red'):
					print('door at: x: ', str(column) , ' y: ' + str(row))  
					var gate_instance = gate.instance()
					add_child(gate_instance)
					gate_instance.rotation_degrees = 90
					gate_instance.start(column*16 + 14,row*16+24)
#				if image.get_pixel(column, row - 1) == ColorN('red'):
#					print('door at: x: ', str(column) , ' y: ' + str(row)) 
#					var gate_instance = gate.instance()
#					add_child(gate_instance)
#					gate_instance.start(column*16,row*16)
#					gate_instance.set_as_toplevel(true)
				
#				if image.get_pixel(column + 1, row) == ColorN('red'):
#					var gate_instance = gate.instance()
#					gate_instance.position = Vector2(column*16, row*16)
#					add_child(gate_instance)
#				if image.get_pixel(column, row + 1) == ColorN('red'):
#					var gate_instance = gate.instance()
#					gate_instance.rotation_degrees = 90
#					gate_instance.position = Vector2(column*16, row*16)
#					add_child(gate_instance)
					
	map_texture.unlock()