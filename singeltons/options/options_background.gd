extends ColorRect

@onready var animation_player: AnimationPlayer = %AnimationPlayer

func _ready() -> void:
	mouse_filter = Control.MOUSE_FILTER_IGNORE

func _open():
	mouse_filter = Control.MOUSE_FILTER_STOP
	animation_player.play("open")

func _close():
	mouse_filter = Control.MOUSE_FILTER_IGNORE
	animation_player.play_backwards("open")
