class_name Player
extends CharacterBody2D

@export var speed := 300.0
@export var jump_velocity := -500.0

@onready var skin: AnimatedSprite2D = $Skin

func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity += get_gravity() * delta
	
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = jump_velocity
	
	var direction := Input.get_axis("move_left", "move_right")
	if direction:
		velocity.x = direction * speed
		skin.flip_h = direction < 0
	else:
		velocity.x = move_toward(velocity.x, 0, speed)
	
	if not is_on_floor():
		skin.play("jump")
	elif direction:
		skin.play("walk")
	else:
		skin.play("idle")
	
	move_and_slide()
