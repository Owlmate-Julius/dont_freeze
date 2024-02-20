extends Node

@export var game_stats : GameStats
@export var fuel_duration : int = 4

var fuel_timer = Timer.new()

func _ready():
	add_child(fuel_timer)
	fuel_timer.start(fuel_duration)
	fuel_timer.timeout.connect(func(): game_stats.furnace_fuel -= 1; print("FUEL: "+str(game_stats.furnace_fuel)))

