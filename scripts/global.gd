extends Node

var lives: int = 3
var current_minigame: int = 1
const TOTAL_MINIGAMES: int = 2

func reset() -> void:
	lives = 3
	current_minigame = 1

func prompt() -> String:
	if current_minigame == 1:
		return "GRAB 3"
	return "CLICK 5"

func go_level() -> void:
	get_tree().change_scene_to_file("res://scenes/level.tscn")

func start_current() -> void:
	if current_minigame == 1:
		get_tree().change_scene_to_file("res://scenes/minigame_1.tscn")
	else:
		get_tree().change_scene_to_file("res://scenes/minigame_2.tscn")

func lose_life() -> void:
	lives -= 1
	if lives <= 0:
		get_tree().change_scene_to_file("res://scenes/death.tscn")
	else:
		go_level()

func win_minigame() -> void:
	current_minigame += 1
	if current_minigame > TOTAL_MINIGAMES:
		get_tree().change_scene_to_file("res://scenes/win.tscn")
	else:
		go_level()	
