extends Item2D

var used : bool = false
var anim_name : String = "HandHitting"

func _ready():
	$Area2D.monitoring = false
	$AnimationPlayer.root_node = self.get_path()
	
func _process(delta):
	var animation = $AnimationPlayer.get_animation(anim_name) # replace with your track name
	var track = animation.find_track("Area2D:position") # or an integer
	#print(target_pos)
	animation.track_set_key_value(track, 1, target_pos.normalized() * 6)
	animation.track_set_key_value(track, 2, target_pos.normalized() * 6)
	#print(animation.track_get_key_value(track, 1))
			
func use():
	if !used:
		used = true
		$Timer.start(0.5)
		$AnimationPlayer.play("HandHitting")

func _on_Timer_timeout():
	used = false





func _on_Area2D_body_entered(body):
	if body.is_in_group('entity') and body != parent:
		body.damage(1)
