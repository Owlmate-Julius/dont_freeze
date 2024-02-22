extends Sprite2D

@onready var stats_component = $StatsComponent


#enum HurtState {
	#NOT_HURT,
	#HURT_DEGREE_1,
	#HURT_DEGREE_2
#}
#var hurt_state = HurtState.NOT_HURT


func _ready():
	stats_component.heath_changed.connect(_on_tree_hurt)


func _on_tree_hurt(current_health):
	if current_health > 8:
		frame = 0
	elif current_health > 5:
		await get_tree().create_timer(0.5).timeout
		frame = 1
	elif current_health > 0:
		await get_tree().create_timer(0.5).timeout
		frame = 2
	else:
		await get_tree().create_timer(0.5).timeout
		queue_free()
