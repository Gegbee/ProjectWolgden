extends Entity2D

const SPEED = 300
const FORCE = 0.052
export (int, "Seek", "Flee") var mode = 0
var velocity : Vector2

onready var player_vars = get_node("/root/PlayerVars")
#var target = player_vars.position

func _ready():
	randomize()
	wander()

func _physics_process(delta):
	var target = get_global_mouse_position()
	velocity = steer(target)
	move_and_slide(velocity)


func steer(target : Vector2) -> Vector2:
	var helper = (target - get_position()).normalized() * SPEED 
	var desired_velocity = Vector2(helper.x, helper.y)
	
	var steer = desired_velocity - velocity
	var target_velocity = velocity + (steer * FORCE )
	return target_velocity
	
func wander():
	var directions = [Vector2(1, 0), Vector2(-1, 0), Vector2(0, 1), Vector2(0, -1)]
	var rand_dir = directions[randi() % directions.size()]
	
	$Wall_Cast.cast_to = rand_dir * 20
	if !$Wall_Cast.is_colliding():
		move(rand_dir * 15)
	else:
		var rand_dir = directions[randi() % directions.size()]