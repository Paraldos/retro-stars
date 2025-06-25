extends CanvasLayer

@onready var background_rect: ColorRect = %BackgroundRect
@onready var animation_main: AnimationPlayer = %AnimationMain
@onready var animation_credits: AnimationPlayer = %AnimationCredits

var main_is_open = false
var credits_is_open = false

func _ready() -> void:
	background_rect.mouse_filter = Control.MOUSE_FILTER_IGNORE

func _physics_process(delta: float) -> void:
	if Input.is_action_just_pressed("open_menu"):
		if credits_is_open:
			_close_redits()
		elif main_is_open:
			_close_main()
		else:
			_open_main()

func _is_animation_playing():
	if animation_main.is_playing(): return true
	if animation_credits.is_playing(): return true
	return false

func _open_main():
	if main_is_open: return
	if _is_animation_playing(): return
	main_is_open = true
	get_tree().paused = true
	background_rect.mouse_filter = Control.MOUSE_FILTER_STOP
	animation_main.play('open')

func _close_main():
	if !main_is_open: return
	if _is_animation_playing(): return
	main_is_open = false
	get_tree().paused = false
	animation_main.play_backwards('open')
	await animation_main.animation_finished
	background_rect.mouse_filter = Control.MOUSE_FILTER_IGNORE

func _open_credits():
	if credits_is_open: return
	if _is_animation_playing(): return
	credits_is_open = true
	animation_main.play_backwards('open')
	animation_credits.play("open")

func _close_redits():
	if !credits_is_open: return
	if _is_animation_playing(): return
	credits_is_open = false
	animation_main.play('open')
	animation_credits.play_backwards("open")

func _on_return_btn_pressed() -> void:
	_close_main()

func _on_button_credits_pressed() -> void:
	if credits_is_open:
		_close_redits()
	else:
		_open_credits()
