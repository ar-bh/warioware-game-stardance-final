extends Node
var lives: int = 3
var current_minigame: int = 1
const TOTAL_MINIGAMES: int = 2

func reset() -> void:
	lives = 3
	current_minigame = 1

func lose_life() -> void:
	lives -= 1
	print("lost a life, now ", lives)
	get_tree().reload_current_scene()

func win_minigame() -> void:
	print("won minigame")
	get_tree().reload_current_scene()
