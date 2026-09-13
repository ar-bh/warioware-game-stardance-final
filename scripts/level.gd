extends Control

@onready var prompt: Label = %Prompt
@onready var count: Label = %Count
@onready var lives: Label = %Lives

func _ready() -> void:
	prompt.text = Global.prompt()
	count.text = ""
	lives.text = "x%d" % Global.lives
	_run()

func _run() -> void:
	await get_tree().create_timer(0.7).timeout
	for n in ["3", "2", "1", "GO!"]:
		count.text = n
		await get_tree().create_timer(0.45).timeout
	Global.start_current()
	
