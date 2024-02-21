@tool
class_name ConfirmBox extends Control

signal has_confirmed(bool)

@onready var text_label = %TextLabel
@onready var confirm_yes_border = %ConfirmYesBorder
@onready var confirm_no_border = %ConfirmNoBorder

@export var text : String = "Confirm ?" :
	set(_value): 
		text = _value
		text_label.text = text

var is_choice_yes : bool = true


func _process(delta):
	if not Engine.is_editor_hint():
		if Input.is_action_just_pressed("interact"):
			has_confirmed.emit(is_choice_yes)
			close()
		if Input.is_action_just_pressed("move_left") and not is_choice_yes:
			is_choice_yes = true
			confirm_yes_border.show()
			confirm_no_border.hide()
		if Input.is_action_just_pressed("move_right") and is_choice_yes:
			is_choice_yes = false
			confirm_yes_border.hide()
			confirm_no_border.show()


func display():
	if not visible:
		GlobalEvents.ui_panel_opened.emit()
		process_mode = Node.PROCESS_MODE_INHERIT
		show()


func close():
	await get_tree().create_timer(.1).timeout
	GlobalEvents.ui_panel_closed.emit()
	hide()
	process_mode = Node.PROCESS_MODE_DISABLED
