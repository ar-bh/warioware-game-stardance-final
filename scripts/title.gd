extends Control

@onready var play_button: Button = %PlayButton

func _ready() -> void:
	play_button.pressed.connect(_play)
	play_button.grab_focus()

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("jump"):
		_play()

func _play() -> void:
	Global.reset()
	Global.go_level()
