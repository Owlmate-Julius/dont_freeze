class_name  StatsComponent extends Node

signal heath_changed
signal no_health

@export var hurtbox : HurtboxComponent
@export var health : float = 10


func _ready():
	hurtbox.hurt.connect(func(damage):
		health -= damage
		if damage >= 0:
			heath_changed.emit(health)
		if health <= 0:
			no_health.emit()
	)
