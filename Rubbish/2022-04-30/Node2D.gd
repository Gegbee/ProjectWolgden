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
#
	for row in image.get_height():
		for column in image.get_width():
			#print(image.get_pixel(column, row))
			if image.get_pixel(column, row) == ColorN("white"):
				$TileMap.set_cell(column, row, 0)
			if image.get_pixel(column, row) == ColorN("black"):
				$TileMap.set_cell(column, row, 1)
	print('done')
	image.unlock()
#
#	var texture_normal = ImageTexture.new()
#	texture_normal.create_from_image(image)
#	$Sprite.texture = texture_normal
# At this point, you have an `Image` with replaced pixels.
# If you want to draw it on screen using a sprite or a mesh instance,
# you can create an ImageTexture from it.

