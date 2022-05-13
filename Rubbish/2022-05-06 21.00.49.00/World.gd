extends Node2D


func _ready():
	hallway_gen()



func hallway_gen():
	var image = Image.new()
	image.load("res://Pixelart/Maps/hallway_test.png")

	image.lock()
	for row in image.get_height():
		for column in image.get_width():
			#print(image.get_pixel(column, row))
			if image.get_pixel(column, row) == ColorN("white"):
				$TileMap.set_cell(column, row, 0)
			if image.get_pixel(column, row) == ColorN("red"):
				$TileMap.set_cell(column, row, 1)
				if image.get_pixel(column + 1, row) == ColorN('red'):
					print('vertical door')
				if image.get_pixel(column, row + 1) == ColorN('red'):
					print('horizontal door')
					
	image.unlock()