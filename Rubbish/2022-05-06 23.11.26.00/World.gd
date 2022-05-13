extends Node2D

onready var gate = preload('res://Main/Gate .tscn')

func _ready():
	hallway_gen()


func hallway_gen():
	var image = Image.new()
	image.load("res://Pixelart/Maps/hallway.png")

	image.lock()
	for row in image.get_height():
		for column in image.get_width():
			#print(image.get_pixel(column, row))
			if image.get_pixel(column, row) == ColorN("white"):
				$TileMap.set_cell(column, row, 0)
			if image.get_pixel(column, row) == ColorN("red"):
				$TileMap.set_cell(column, row, 1)
				if image.get_pixel(column + 1, row) == ColorN('red'):
					var gate_instance = gate.instance()
					gate_instance.position = Vector2(column*16, row*16)
					add_child(gate_instance)
				if image.get_pixel(column, row + 1) == ColorN('red'):
					var gate_instance = gate.instance()
					gate_instance.rotation_degrees = 90
					gate_instance.position = Vector2(column*16, row*16)
					add_child(gate_instance)
					
	image.unlock()