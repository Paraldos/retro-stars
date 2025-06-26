extends CanvasLayer

@onready var rect: ColorRect = %Rect

func _ready() -> void:
	rect.mouse_filter = Control.MOUSE_FILTER_IGNORE

func _open():
	var tween = create_tween()
	rect.mouse_filter = Control.MOUSE_FILTER_STOP
	tween.tween_property(rect, "color", Color(0.0, 0.0, 0.0, 0.686), 0.3)

func _close():
	var tween = create_tween()
	rect.mouse_filter = Control.MOUSE_FILTER_IGNORE
	tween.tween_property(rect, "color", Color(0.0, 0.0, 0.0, 0.0), 0.3)
