extends Node2D


func _ready():
	pass


func hallway_gen():

	var image = Image.new()
	image.load("res://Pixelart/Maps/betamap.png")

	image.lock()
	for row in image.get_height():
		for column in image.get_width():
			#print(image.get_pixel(column, row))
			if image.get_pixel(column, row) == ColorN("white"):
				$TileMap.set_cell(column, row, 0)
	print('done')
	image.unlock()