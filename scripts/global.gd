extends Node

var lives: int = 3
var current_minigame: int = 1

const GAMES := [
	"res://scenes/minigame_1.tscn",
	"res://scenes/minigame_2.tscn",
	"res://scenes/minigame_3.tscn",
	"res://scenes/minigame_2.tscn",
]
const PROMPTS := [
	"GRAB 3",
	"CLICK 5",
	"GRAB 3",
	"CLICK 5",
]
const TITLE := "res://scenes/title.tscn"
const LEVEL := "res://scenes/level.tscn"
const WIN := "res://scenes/win.tscn"
const DEATH := "res://scenes/death.tscn"


func reset() -> void:
	lives = 3
	current_minigame = 1


func prompt() -> String:
	var i := current_minigame - 1
	if i < 0 or i >= PROMPTS.size():
		return "GO!"
	return PROMPTS[i]


func go_level() -> void:
	get_tree().change_scene_to_file(LEVEL)


func start_current() -> void:
	var i := current_minigame - 1
	get_tree().change_scene_to_file(GAMES[i])


func lose_life() -> void:
	lives -= 1
	if lives <= 0:
		get_tree().change_scene_to_file(DEATH)
	else:
		go_level()


func win_minigame() -> void:
	current_minigame += 1
	if current_minigame > GAMES.size():
		get_tree().change_scene_to_file(WIN)
	else:
		go_level()
