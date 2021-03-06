extends TextureProgress

func _ready():
	max_value = get_parent().MAX_HEALTH
	$Timer.start(3)

func updateHealth(new_health : int):
	#$Tween.stop(self, ":modulate")
#	$Tween.interpolate_property(self, "rect_scale", rect_scale, 
#	Vector2(1, 1) * 1.3, 0.2, Tween.TRANS_LINEAR, Tween.EASE_IN)
#
#	$Tween.interpolate_property(self, "rect_scale", rect_scale, 
#	Vector2(1, 1), 2, Tween.TRANS_LINEAR, Tween.EASE_IN, 2)
	$Tween.reset_all()
	$Tween.interpolate_property(self, "modulate", modulate,
	Color(1, 1, 1, 1), 0.2, Tween.TRANS_EXPO, Tween.EASE_IN)
	$Tween.start()
#	$Tween.interpolate_property(self, "modulate", modulate,
#	Color(1, 1, 1, 0), 2, Tween.TRANS_EXPO, Tween.EASE_OUT, 3)
#	$Tween.start()
	$Timer.stop()
	$Timer.start(3)
	value = new_health
	
func _on_Timer_timeout():
	$Tween.interpolate_property(self, "modulate", modulate,
	Color(1, 1, 1, 0), 2, Tween.TRANS_EXPO, Tween.EASE_OUT)
	$Tween.start()
