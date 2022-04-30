extends KinematicBody2D

class_name Entity2D

export var left_hand_path : NodePath
export var right_hand_path : NodePath

var left_hand = null
var right_hand = null

var left_hand_item : Item2D = null
var right_hand_item : Item2D = null

export var MAX_HEALTH : int = 10
export var MAX_SPEED : float = 100.0

var health : int = MAX_HEALTH

func _ready():
	left_hand = get_node(left_hand_path)
	right_hand = get_node(right_hand_path)

func _process(delta):
	if left_hand_item:
		left_hand_item.global_position = left_hand
	if right_hand_item:
		right_hand_item.global_position = right_hand
	
func move(vel : Vector2):
	move_and_slide(vel.normalized() * MAX_SPEED)
	
func useLeftHand():
	pass
	
func useRightHand():
	pass
	
