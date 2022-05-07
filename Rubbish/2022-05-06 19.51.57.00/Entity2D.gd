extends KinematicBody2D

class_name Entity2D

export var left_hand_path : NodePath
export var right_hand_path : NodePath

var left_hand = null
var right_hand = null

var left_hand_item : Item2D = null
var right_hand_item : Item2D = null

export var MIN_ITEM_SIZE : float = 0.3

export var HAND_SPREAD : float = PI/3
export var HAND_DISTANCE_FROM_BODY : float = 10.0

export var MAX_HEALTH : int = 10.0
export var MAX_SPEED : float = 100.0 

var speed : int = MAX_SPEED
var health : int = MAX_HEALTH
var impulse_vector : Vector2 = Vector2.ZERO

var item_in_use : bool = false


func _ready():
	add_to_group('entity')
	left_hand = get_node(left_hand_path)
	right_hand = get_node(right_hand_path)
	
func _process(delta):
	
	if left_hand_item:
		left_hand_item.global_position = left_hand.global_position
	if right_hand_item:
		right_hand_item.global_position = right_hand.global_position
	
func move(vel : Vector2):
	vel = vel.normalized()
	if item_in_use == true:
		speed = MAX_SPEED / 2
	if impulse_vector != Vector2.ZERO:
		vel -= impulse_vector
		yield(get_tree().create_timer(0.1), "timeout")
		impulse_vector = Vector2.ZERO
	else:
		speed = MAX_SPEED
	return move_and_slide(vel * speed).length() > 0
	
func impulse(vel : Vector2, impulse_dir : Vector2):
	var impulse_strength = MAX_SPEED/4
	vel += -impulse_dir * impulse_strength
	return move_and_slide(vel.normalized() * speed - impulse_dir).length() > 0
	
func setHandDir(dir : Vector2):
	# dir is local so you need to make it local before passing it in to this function
	dir = dir.normalized()
	var angle : float = atan2(dir.y, dir.x)
	var left_angle : float = angle + HAND_SPREAD / 2
	var right_angle : float = angle - HAND_SPREAD / 2
	var right_dir : Vector2 = Vector2(cos(right_angle), sin(right_angle))
	var left_dir : Vector2 = Vector2(cos(left_angle), sin(left_angle))
	
	if left_dir.y < 0:
		left_hand.z_index = -1
	else:
		left_hand.z_index = 1
		
	if right_dir.y < 0:
		right_hand.z_index = -1
	else:
		right_hand.z_index = 1
		
	left_hand.position.x = left_dir.x * HAND_DISTANCE_FROM_BODY
	left_hand.position.y = left_dir.y * HAND_DISTANCE_FROM_BODY / 2
	#left_hand_item.scale.x = ((1 - MIN_ITEM_SIZE) * abs(sin(left_angle)) + MIN_ITEM_SIZE) # * sign(sin(left_angle))
	
	right_hand.position.x = right_dir.x * HAND_DISTANCE_FROM_BODY
	right_hand.position.y = right_dir.y * HAND_DISTANCE_FROM_BODY / 2
	#right_hand_item.scale.x = ((1 - MIN_ITEM_SIZE) * abs(sin(right_angle)) + MIN_ITEM_SIZE) # * sign(sin(right_angle))
	if right_hand_item:
		right_hand_item.setTargetPos(dir)
	if left_hand_item:
		left_hand_item.setTargetPos(dir)
		
func addLeftHandItem(new_item_name : String, parent = null):
	if left_hand_item:
		left_hand_item.queue_free()
	var new_item = GlobalItems.item_and_scenes[new_item_name].instance()
	left_hand.add_child(new_item)
	left_hand_item = new_item
	left_hand_item.parent = parent
	
func addRightHandItem(new_item_name : String, parent = null):
	if right_hand_item:
		right_hand_item.queue_free()
	var new_item = GlobalItems.item_and_scenes[new_item_name].instance()
	right_hand.add_child(new_item)
	right_hand_item = new_item
	right_hand_item.parent = parent
	
func __useLeftHand__():
	if left_hand_item:
		left_hand_item.use()
	
func __useRightHand__():
	if right_hand_item:
		right_hand_item.use()
		
func useHand(hand : String):
	item_in_use = true
	if hand.to_lower() == "left":
		__useLeftHand__()
	elif hand.to_lower() == "right":
		__useRightHand__()
		
func damage(dmg : int, impulse_dir : Vector2):
	health -= dmg
	impulse_vector = impulse_dir
	print(self.name + " health: " + str(health) + " / " + str(MAX_HEALTH))
