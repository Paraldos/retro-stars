extends CanvasLayer

@onready var credits: Control = %Credits
@onready var main: Control = %Main


func _physics_process(delta: float) -> void:
	if SceneChanger.is_playing: return
	if Input.is_action_just_pressed("open_menu"):
		if credits.credits_is_open:
			_close_credits()
		elif main.main_is_open:
			_close_main()
		else:
			_open_main()

func _open_main():
	main._open()
	Overlay._open()

func _close_main():
	main._close()
	Overlay._close()

func _open_credits():
	main._pause()
	credits._open()

func _close_credits():
	main._unpause()
	credits._close()

func _on_credits_close_credits() -> void:
	_close_credits()

func _on_main_return_to_game() -> void:
	_close_main()

func _on_main_open_credits() -> void:
	_open_credits()
