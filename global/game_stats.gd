class_name GameStats extends Resource

signal stats_changed

@export var furnace_fuel : float : 
	set(_value): furnace_fuel = _value; stats_changed.emit()
@export var current_day : int :
	set(_value): current_day = _value; stats_changed.emit()

