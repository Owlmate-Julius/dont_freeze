class_name Item extends Resource

@export var name : String = ""
@export var type : Type = Type.FUEL
@export var amount : int = 1

@export_group("Weapon")
@export var can_chop : bool
@export var chop_strength : float

@export_group("Equip Stats")
@export var strength : float
@export var deffence : float
@export var luck : float

@export_group("Food")
@export var food_fill : float

@export_group("Fuel")
@export var fuel_fill : float

enum Type {
	FUEL,
	FOOD,
	WEAPON,
	ARMOR
}
