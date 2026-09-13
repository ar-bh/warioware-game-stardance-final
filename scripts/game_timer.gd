extends CanvasLayer

signal timed_out

@export var seconds: float = 8.0
@onready var label: Label = $Label
var _running := true

func _process(delta: float) -> void:
	if not _running:
		return
	seconds -= delta
	label.text = str(ceili(maxf(seconds, 0.0)))
	if seconds <= 0.0:
		_running = false
		timed_out.emit()
	
func stop() -> void:
	_running = false
