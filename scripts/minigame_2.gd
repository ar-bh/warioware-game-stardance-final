extends Node2D

const NEED := 5
const TOPPING_SCENE := preload("res://scenes/topping.tscn")
const TEXTURES := [
	preload("res://assets/collectible/toppings/mushroom.png"),
	preload("res://assets/collectible/toppings/cheese.png"),
	preload("res://assets/collectible/toppings/tomato.png"),
	preload("res://assets/collectible/toppings/sausage.png"),
	preload("res://assets/collectible/toppings/pineapple.png"),
]

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

func _spawn() -> void:
	var used: Array[Vector2] = []
	for tex in TEXTURES:
		var topping: Area2D = TOPPING_SCENE.instantiate()
		var pos := Vector2(randf_range(160.0, 1120.0), randf_range(180.0, 580.0))
		for _i in 20:
			var ok := true
			for other in used:
				if pos.distance_to(other) < 140.0:
					ok = false
					break
			if ok:
				break
			pos = Vector2(randf_range(160.0, 1120.0), randf_range(180.0, 580.0))
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
