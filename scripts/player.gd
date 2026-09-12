class_name PeppinoPlayer
extends CharacterBody2D

@export var speed := 300.0
@export var jump_velocity := -500.0
@export var coyote_time := 0.1
@export var jump_buffer_time := 0.12
@export var fall_multiplier := 1.4

@onready var skin: AnimatedSprite2D = $Skin

var coyote := 0.0
var jump_buffer := 0.0

func _physics_process(delta: float) -> void:
	if is_on_floor():
		coyote = coyote_time
	else:
		var gravity := get_gravity()
		if velocity.y > 0.0:
			gravity *= fall_multiplier
		velocity += gravity * delta
		coyote -= delta
	
	if Input.is_action_just_pressed("jump"):
		jump_buffer = jump_buffer_time
	else:
		jump_buffer -= delta
	
	if jump_buffer > 0.0 and coyote > 0.0:
		velocity.y = jump_velocity
		coyote = 0.0
		jump_buffer = 0.0
	
	if Input.is_action_just_released("jump") and velocity.y < 0.0:
		velocity.y *= 0.45
	
	var direction := Input.get_axis("move_left", "move_right")
	if direction:
		velocity.x = direction * speed
		skin.flip_h = direction < 0
	else:
		velocity.x = move_toward(velocity.x, 0.0, speed)
	
	if not is_on_floor():
		skin.play("jump")
	elif direction:
		skin.play("walk")
	else:
		skin.play("idle")
	
	move_and_slide()
