class_name HitboxComponent extends Area2D

@export var damage = 1.0

func _ready():
	area_entered.connect(_on_hurtbox_entered)

func _on_hurtbox_entered(hurtbox: HurtboxComponent):
	print(hurtbox.owner.name)
	if not hurtbox is HurtboxComponent: return
	if hurtbox.is_invincible: return
	hurtbox.hurt.emit(damage)


func enable_for(sec : float):
	for child in get_children():
		if not child is CollisionShape2D and not child is CollisionPolygon2D: continue
		child.set_deferred("disabled", false)
	$Timer.start(sec)
	await $Timer.timeout
	for child in get_children():
		if not child is CollisionShape2D and not child is CollisionPolygon2D: continue
		child.set_deferred("disabled", true)
