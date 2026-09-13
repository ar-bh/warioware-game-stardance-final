extends Node2D

const NEED := 3

var grabbed := 0
var ended := false

@onready var timer: CanvasLayer = $GameTimer
@onready var prompt: Label = %Prompt
@onready var lives: Label = %Lives

func _ready() -> void:
	prompt.text = Global.prompt()
	lives.text = "x%d" % Global.lives
	timer.timed_out.connect(_lose)
	$Kill.body_entered.connect(_on_kill)
	var cam: Camera2D = $Player/Camera2D
	cam.limit_left = 0
	cam.limit_top = 0
	cam.limit_right = 1568
	cam.limit_bottom = 864
	for pizza in get_tree().get_nodes_in_group("pizza"):
		pizza.collected.connect(_on_pizza)
	
func _on_pizza() -> void:
	grabbed += 1
	if grabbed >= NEED:
		_win()

func _on_kill(body: Node2D) -> void:
	if body is PeppinoPlayer:
		_lose()

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
