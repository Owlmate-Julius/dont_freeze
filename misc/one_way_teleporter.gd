extends Area2D

@export var enabled : bool = true
@export var target_camera : Camera2D
@export var lock_x : bool = false
@export var lock_y : bool = false
@export var disable_on_teleport : bool = false


func _ready():
	body_entered.connect(_on_body_entered)
	body_exited.connect(_on_body_exited)
	if not enabled:
		disable()


func enable():
	enabled = true
	for child in get_children():
		if child is CollisionShape2D or child is CollisionPolygon2D:
			child.disabled = false


func disable():
	enabled = false
	for child in get_children():
		if child is CollisionShape2D or child is CollisionPolygon2D:
			child.set_deferred("disabled", true)


func _on_body_entered(_body : CharacterBody2D):
	if lock_x:
		_body.global_position.y = get_node("Marker2D").global_position.y
	elif lock_y:
		_body.global_position.x = get_node("Marker2D").global_position.x
	else:
		_body.global_position = get_node("Marker2D").global_position
	
	if target_camera:
		target_camera.enabled = true
		target_camera.make_current()
	
	
func _on_body_exited(_body : CharacterBody2D):
	if disable_on_teleport:
		disable()

