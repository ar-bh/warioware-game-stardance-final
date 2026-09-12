extends TextureRect

@export var amount := 0.06
@export var smoothness := 6.0

@onready var player: CharacterBody2D = $"../Player"

var home: Vector2
var current: Vector2

func _ready() -> void:
	home = position
	current = home
	
func _process(delta: float) -> void:
	var center := Vector2(640, 360)
	var target := home - (player.global_position - center) * amount
	current = current.lerp(target, 1.0 - exp(-smoothness * delta))
	position = current
