extends CharacterBody2D

@onready var anim = $AnimatedSprite2D

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
	GlobalEvents.ui_panel_opened.connect(func(): process_mode = PROCESS_MODE_DISABLED)
	GlobalEvents.ui_panel_closed.connect(x)

func x():
	process_mode = Node.PROCESS_MODE_INHERIT

func _physics_process(delta):
	var direction = Input.get_axis("move_left", "move_right")
	match current_state:
		States.IDLE:
			velocity.x = move_toward(velocity.x, 0, SPEED)
			if direction:
				current_state = States.WALK
		States.WALK:
			velocity.x = direction * SPEED
			if not direction:
				current_state = States.IDLE
			else:
				anim.flip_h = velocity.x > 0
		States.ATTACK:
			pass
	
	if not is_on_floor():
		velocity.y += gravity * delta
	
	if Input.is_action_just_pressed("move_up") and is_on_floor():
		velocity.y = JUMP_VELOCITY
	
	
	move_and_slide()
