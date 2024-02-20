extends AnimatedSprite2D

@export var game_stats : GameStats
@export var inventory : Inventory

@onready var fuel_counter = $FuelCounterLabel
@onready var fuel_container = $FuelContainer

const FUEL_ITEM = preload("res://ui/fuel_item_container.tscn")

func _ready():
	fuel_counter.text = str(game_stats.furnace_fuel)
	game_stats.stats_changed.connect(func():
		fuel_counter.text = str(game_stats.furnace_fuel)
	)
	visible = false


func _process(delta):
	if visible and Input.is_action_just_pressed("esc"):
		close_panel()


func refill():
	var items : Array[Item] = inventory.remove_items_by_type(Item.Type.FUEL)
	for item in items:
		var fuel_item : FuelItem = FUEL_ITEM.instantiate()
		fuel_container.add_child(fuel_item)
		fuel_item.setup(item.name, item.amount)
		game_stats.furnace_fuel += item.amount * item.fuel_fill
	fuel_counter.text = str(game_stats.furnace_fuel)


func open_panel():
	GlobalEvents.ui_panel_opened.emit()
	visible = true
	refill()


func close_panel():
	GlobalEvents.ui_panel_closed.emit()
	visible = false
	for item in fuel_container.get_children():
		fuel_container.remove_child(item)
		item.queue_free()




