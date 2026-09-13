extends Sprite2D

@export var amount := 0.1
@export var smoothness := 6.0
@export var cover_padding := 1.12

@onready var player: CharacterBody2D = $"../Player"

var home: Vector2
var current: Vector2
var origin: Vector2

func _ready() -> void:
	centered = true
	_center_on_view()
	home = position
	current = home
	origin = player.global_position
	get_tree().root.size_changed.connect(_on_resize)

func _on_resize() -> void:
	var old_home := home
	_center_on_view()
	var delta := position - old_home
	home = position
	current += delta

func _center_on_view() -> void:
	var view := get_viewport().get_visible_rect().size
	var game := Vector2(1280, 720)
	var fit := minf(view.x / game.x, view.y / game.y)
	var game_size := game * fit
	var view_origin := (view - game_size) * 0.5
	position = view_origin + game_size * 0.5
	if texture == null:
		return
	var tex := texture.get_size()
	var need := game_size * cover_padding
	scale = Vector2(need.x / tex.x, need.y / tex.y)
	
func _process(delta: float) -> void:
	var target := home - Vector2((player.global_position.x - origin.x) * amount, 0.0)
	current = current.lerp(target, 1.0 - exp(-smoothness * delta))
	position = current
