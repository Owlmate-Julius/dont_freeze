extends Area2D

@export var action_key_name : String = ""
@export var target_node : Node = null
@export var target_function_name : String = ""
@export var one_shot : bool = false: set = set_one_shot

var lock = false
var can_interact = false


func _ready():
	body_entered.connect(func(_body): can_interact = true)
	body_exited.connect(func(_body): can_interact = false)


func _process(delta):
	if not lock:
		if can_interact and Input.is_action_just_pressed(action_key_name):
			if one_shot: lock = true
			target_node.call(target_function_name)


func set_one_shot(_value):
	one_shot = _value
	if not one_shot:
		lock = false


