class_name Inventory extends Resource

signal weapon_equipped

@export var items : Array[Item]
@export var equipped_weapon : Item = null : set = equip_weapon # type: WEAPON
@export var equipped_armor : Item = null # type ARMOR


func add_item(_item : Item, amount : int = 1):
	var idx = items.find(_item)
	if idx == -1:
		items.append(_item)
	else:
		items[idx].amount += amount
	#for item in items:
		#if item.name == _item.name:
			#item.amount += amount
			#return


func equip_weapon(weapon):
	equipped_weapon = weapon
	weapon_equipped.emit(weapon.Type)


func get_items_by_type(type : Item.Type) -> Array[Item]:
	return []


func remove_items_by_type(type : Item.Type) -> Array[Item]:
	var selected_items : Array[Item] = []
	for item in items:
		if item.type == type:
			selected_items.append(item)
	for item in selected_items:
		items.erase(item)
	return selected_items
