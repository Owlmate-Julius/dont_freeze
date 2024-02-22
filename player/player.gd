extends CharacterBody2D

@export var player_stats : PlayerStats
@export var inventory : Inventory

@onready var anim = $PlayerFacingSide/AnimatedSprite2D
@onready var player_facing_side = $PlayerFacingSide
@onready var hitbox_component = $PlayerFacingSide/HitboxComponent

const SPEED = 30.0
const JUMP_VELOCITY = -100.0

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

enum States {
	IDLE,
	WALK,
	ATTACK
}
var current_state = States.IDLE


func _ready():
	GlobalEvents.ui_panel_opened.connect(func():
		set_physics_process(false)
		idle()
		current_state = States.IDLE
	)
	GlobalEvents.ui_panel_closed.connect(func(): 
		set_physics_process(true)
	)
	player_stats.changed.connect(update_stats)
	inventory.weapon_equipped.connect(update_stats)
	update_stats()
	

func _physics_process(delta):
	match current_state:
		States.IDLE:
			idle()
		States.WALK:
			walk()
		States.ATTACK:
			attack()
	
	if not is_on_floor():
		velocity.y += gravity * delta
	
	if Input.is_action_just_pressed("move_up") and is_on_floor():
		velocity.y = JUMP_VELOCITY
	
	
	move_and_slide()


func idle():
	if not anim.animation == "axe_attack":
		anim.play("axe")
	var direction = Input.get_axis("move_left", "move_right")
	velocity.x = move_toward(velocity.x, 0, SPEED)
	if direction:
		current_state = States.WALK
	if Input.is_action_just_pressed("interact"):
		current_state = States.ATTACK


func attack():
	anim.play("axe_attack")
	hitbox_component.enable_for(0.1)
	if Input.is_action_just_released("interact"):
		current_state = States.IDLE


func walk():
	anim.play("axe_walk")
	var direction = Input.get_axis("move_left", "move_right")
	velocity.x = direction * SPEED
	if not direction:
		current_state = States.IDLE
	else:
		player_facing_side.scale.x = 1 if velocity.x > 0 else -1
	if Input.is_action_just_pressed("interact"):
		current_state = States.ATTACK


func update_stats():
	hitbox_component.damage = (1 + player_stats.strength * 0.1) * inventory.equipped_weapon.strength












