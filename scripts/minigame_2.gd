extends Node2D

const NEED := 5
const TOPPING_SCENE: PackedScene = preload("res://scenes/topping.tscn")
const TEXTURES := [
	preload("res://assets/collectible/toppings/mushroom.png"),
	preload("res://assets/collectible/toppings/cheese.png"),
	preload("res://assets/collectible/toppings/tomato.png"),
	preload("res://assets/collectible/toppings/sausage.png"),
	preload("res://assets/collectible/toppings/pineapple.png"),
]

const SPAWN_LEFT := 280.0
const SPAWN_RIGHT := 1000.0
const SPAWN_TOP := 220.0
const SPAWN_BOTTOM := 520.0
const SPACING := 140.0

var clicked := 0
var ended := false

@onready var timer: CanvasLayer = $GameTimer
@onready var prompt: Label = %Prompt
@onready var lives: Label = %Lives

func _ready() -> void:
	prompt.text = Global.prompt()
	lives.text = "x%d" % Global.lives
	timer.timed_out.connect(_lose)
	_spawn()

func _random_pos() -> Vector2:
	return Vector2(randf_range(SPAWN_LEFT, SPAWN_RIGHT), randf_range(SPAWN_TOP, SPAWN_BOTTOM))

func _spawn() -> void:
	var used: Array[Vector2] = []
	for tex in TEXTURES:
		var topping: Area2D = TOPPING_SCENE.instantiate()
		var pos := _random_pos()
		for _i in 20:
			var ok := true
			for other in used:
				if pos.distance_to(other) < SPACING:
					ok = false
					break
			if ok:
				break
			pos = _random_pos()
		used.append(pos)
		topping.position = pos
		topping.get_node("Sprite").texture = tex
		topping.collected.connect(_on_topping)
		$Toppings.add_child(topping)

func _on_topping() -> void:
	clicked += 1
	if clicked >= NEED:
		_win()

func _win() -> void:
	if ended:
		return
	ended = true
	timer.stop()
	Global.win_minigame()

func _lose() -> void:
	if ended:
		return
	ended = true
	timer.stop()
	Global.lose_life()
