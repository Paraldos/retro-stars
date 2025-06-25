extends CanvasLayer

@onready var background_rect: ColorRect = %BackgroundRect

@onready var animation_main: AnimationPlayer = %AnimationMain
@onready var main_content: VBoxContainer = %MainContent
@onready var button_credits: Button = %ButtonCredits
@onready var return_btn: Button = %ReturnBtn

@onready var close_credits_btn: Button = %CloseCreditsBtn
@onready var animation_credits: AnimationPlayer = %AnimationCredits

var main_is_open = false
var credits_is_open = false
var main_focus

func _ready() -> void:
	main_focus = return_btn
	background_rect.mouse_filter = Control.MOUSE_FILTER_IGNORE
	for child in main_content.get_children():
		if child.has_signal('focus_entered'):
			child.focus_entered.connect(_on_main_focus_entered)

func _on_main_focus_entered():
	for child in main_content.get_children():
		if child.has_focus():
			main_focus = child

func _physics_process(delta: float) -> void:
	if Input.is_action_just_pressed("open_menu"):
		if credits_is_open:
			_close_credits()
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
	main_focus.grab_focus()

func _close_main():
	if !main_is_open: return
	if _is_animation_playing(): return
	main_is_open = false
	main_focus.release_focus()
	animation_main.play_backwards('open')
	get_tree().paused = false
	await animation_main.animation_finished
	background_rect.mouse_filter = Control.MOUSE_FILTER_IGNORE

func _open_credits():
	if credits_is_open: return
	if _is_animation_playing(): return
	credits_is_open = true
	animation_main.play("pause")
	animation_credits.play("open")
	close_credits_btn.grab_focus()

func _close_credits():
	if !credits_is_open: return
	if _is_animation_playing(): return
	credits_is_open = false
	animation_main.play_backwards("pause")
	animation_credits.play_backwards("open")
	close_credits_btn.release_focus()
	main_focus.grab_focus()

func _on_return_btn_pressed() -> void:
	_close_main()

func _on_button_credits_pressed() -> void:
	_open_credits()

func _on_close_credits_btn_pressed() -> void:
	_close_credits()
