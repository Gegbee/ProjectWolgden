extends Node2D

onready var gate = preload('res://Main/Gate .tscn')

func _ready():
	hallway_gen()

func _process(delta):
	var mouse_pos = get_global_mouse_position()
	if mouse_pos != null:
		$Sprite.position = mouse_pos
		$Label.set_text(str(mouse_pos))
		$Label2.set_text(str(mouse_pos/16))

func hallway_gen():
	var image = Image.new()
	image.load("res://Pixelart/Maps/hallway.png")

	var gate_instance = gate.instance()
	image.lock()
	for row in image.get_height():
		for column in image.get_width():
			#print(image.get_pixel(column, row))
			if image.get_pixel(column, row) == ColorN("white"):
				$TileMap.set_cell(column, row, 0)
			if image.get_pixel(column, row) == ColorN("red"):
				$TileMap.set_cell(column, row, 1)
				if image.get_pixel(column + 1, row) == ColorN('red'):
					print('door at: x: ', str(column) , ' y: ' + str(row))
					add_child(gate_instance)
					gate_instance.start(column*16,row*16)
				if image.get_pixel(column - 1, row) == ColorN('red'):
					print('door at: x: ', str(column) , ' y: ' + str(row))  
					add_child(gate_instance)
					gate_instance.start(column*16,row*16)
				if image.get_pixel(column, row + 1) == ColorN('red'):
					print('door at: x: ', str(column) , ' y: ' + str(row))  
					add_child(gate_instance)
					gate_instance.start(column*16,row*16)
				if image.get_pixel(column, row - 1) == ColorN('red'):
					print('door at: x: ', str(column) , ' y: ' + str(row)) 
					add_child(gate_instance)
					gate_instance.start(column*16,row*16)
				
#				if image.get_pixel(column + 1, row) == ColorN('red'):
#					var gate_instance = gate.instance()
#					gate_instance.position = Vector2(column*16, row*16)
#					add_child(gate_instance)
#				if image.get_pixel(column, row + 1) == ColorN('red'):
#					var gate_instance = gate.instance()
#					gate_instance.rotation_degrees = 90
#					gate_instance.position = Vector2(column*16, row*16)
#					add_child(gate_instance)
					
	image.unlock()