extends Node2D


func _ready():
#	# Get the image ONCE
#	var texture = ImageTexture.new()
	var image = Image.new()
	image.load("res://Pixelart/Maps/betamap.png")
#	texture.create_from_image(image)
#	$Sprite.texture = texture

	#var image = texture_normal.get_data()

# Lock it
	image.lock()
	print(image)
	for row in image.get_height():
		for column in image.get_width():
			#print(image.get_pixel(column, row))
			if image.get_pixel(column, row) == ColorN("white"):
				$TileMap.set_cell(column, row, 0)
	print('done')
	image.unlock()
#