extends Node

@export var player_inventory : Inventory
@export var items : Array[ItemDropCFG]


func drop_items():
	for item_cfg in items:
		item_cfg = item_cfg as ItemDropCFG
		player_inventory.add_item(item_cfg.item, randi_range(item_cfg.min_amount, item_cfg.max_amount))
