extends Sprite


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	var staticbody = StaticBody2D.new()
	add_child(staticbody)
	var col = CollisionShape2D.new()
	staticbody.add_child(col)
	var shape : RectangleShape2D = RectangleShape2D.new()
	shape.set_extents(Vector2(texture.get_width()/2, texture.get_height() / 4))
	col.set_shape(shape)
	col.position.y = texture.get_width() / 4
