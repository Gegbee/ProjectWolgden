extends Entity2D

enum {
	USING_LEFT_HAND,
	USING_RIGHT_HAND,
	USING_NO_HAND
}
var state = USING_NO_HAND
onready var player_vars = get_node("/root/PlayerVars")

const scent_scene = preload('res://Player/Scent.tscn')
var facing_dir : Vector2

var scent_trail = []

func _ready():
	$Timer.connect('timeout', self, 'add_scent')
	
	addLeftHandItem("hand", self)
	addRightHandItem("hand", self)
	
func _physics_process(delta):
	facing_dir = get_local_mouse_position()
	player_vars.position = global_position
	player_vars.scent_trail = scent_trail
	
	
	var x = Input.get_action_strength("right")-Input.get_action_strength("left")
	var y = Input.get_action_strength("down")-Input.get_action_strength("up")
	var moving = move(Vector2(x, y))
	
	if moving:
		if get_local_mouse_position().y < 0:
			$AnimatedSprite.play("RunningBack")
		else:
			$AnimatedSprite.play("RunningFront")
	else:
		if get_local_mouse_position().y < 0:
			$AnimatedSprite.play("IdleBack")
		else:
			$AnimatedSprite.play("IdleFront")
	if get_local_mouse_position().x > 0:
		$AnimatedSprite.flip_h = false
	else:
		$AnimatedSprite.flip_h = true
		
	setHandDir(get_local_mouse_position())
	
	if state == USING_LEFT_HAND:
		useHand("left")
	elif state == USING_RIGHT_HAND:
		useHand("right")
	else:
		item_in_use = false
		
	if Input.is_action_just_pressed("left_click"):
		state = USING_LEFT_HAND
	elif Input.is_action_just_pressed("right_click"):
		state = USING_RIGHT_HAND
	if Input.is_action_just_released("left_click"):
		if state != USING_RIGHT_HAND:
			state = USING_NO_HAND
	if Input.is_action_just_released("right_click"):
		if state != USING_LEFT_HAND:
			state = USING_NO_HAND

func add_scent():
	var scent = scent_scene.instance()
	scent.position = self.position

	get_parent().add_child(scent)
	scent_trail.push_front(scent)
