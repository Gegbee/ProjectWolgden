extends Entity2D

const SPEED = 300
const FORCE = 0.02
export (int, "Seek", "Flee") var mode = 0
var velocity : Vector2

onready var player_vars = get_node("/root/PlayerVars")
#var target = player_vars.position


func _physics_process(delta):
	var target = get_global_mouse_position()
	velocity = steer(target)
	move_and_slide(velocity)


func steer(target : Vector2) -> Vector2:
	var helper= (target - get_position()).normalized() * SPEED 
	var desired_velocity = Vector2(helper.x, helper.y)
	
	if mode == 1: # Flee
		desired_velocity = -desired_velocity
		
	var steer = desired_velocity - velocity
	var target_velocity = velocity + (steer * FORCE )
	return target_velocity
	