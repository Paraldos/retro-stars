extends CanvasLayer

@onready var animation_player: AnimationPlayer = %AnimationPlayer

func _open():
	get_tree().paused = true
	Overlay._open()
	animation_player.play("open")
