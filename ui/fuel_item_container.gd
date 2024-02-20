class_name FuelItem extends HBoxContainer

@onready var item_name_label = $ItemNameLabel
@onready var amout_label = $AmoutLabel


func setup(name : String = "", amount : int = 0):
	item_name_label.text = name
	amout_label.text = str(amount)
