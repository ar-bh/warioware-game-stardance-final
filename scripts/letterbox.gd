extends CanvasLayer

const FILL := Color(0.27058825, 0.1764706, 0.31764707)
const GAME := Vector2(1280, 720)

var _left: ColorRect
var _right: ColorRect
var _top: ColorRect
var _bottom: ColorRect


func _ready() -> void:
	layer = 128
	_left = _make_bar()
	_right = _make_bar()
	_top = _make_bar()
	_bottom = _make_bar()
	get_tree().root.size_changed.connect(_update_bars)
	_update_bars()


func _make_bar() -> ColorRect:
	var rect := ColorRect.new()
	rect.color = FILL
	rect.mouse_filter = Control.MOUSE_FILTER_IGNORE
	add_child(rect)
	return rect


func _update_bars() -> void:
	var size := get_viewport().get_visible_rect().size
	var scale := minf(size.x / GAME.x, size.y / GAME.y)
	var game_size := GAME * scale
	var origin := (size - game_size) * 0.5
	_left.position = Vector2.ZERO
	_left.size = Vector2(origin.x, size.y)
	_right.position = Vector2(origin.x + game_size.x, 0)
	_right.size = Vector2(size.x - _right.position.x, size.y)
	_top.position = Vector2.ZERO
	_top.size = Vector2(size.x, origin.y)
	_bottom.position = Vector2(0, origin.y + game_size.y)
	_bottom.size = Vector2(size.x, size.y - _bottom.position.y)
