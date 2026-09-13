extends Control

func _ready() -> void:
	%Again.pressed.connect(_again)
	%Again.grab_focus()

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("jump"):
		_again()

func _again() -> void:
	Global.reset()
	get_tree().change_scene_to_file("res://scenes/title.tscn")
