extends Control

@onready var animation_player: AnimationPlayer = %AnimationPlayer
@onready var main_content: VBoxContainer = %MainContent
@onready var return_btn: Button = %ReturnBtn
var main_is_open = false
var main_focus
var animation_done = true

signal return_to_game
signal open_credits

func _ready() -> void:
	main_focus = return_btn
	for child in main_content.get_children():
		if child.has_signal('focus_entered'):
			child.focus_entered.connect(_on_main_focus_entered)

func _on_main_focus_entered():
	for child in main_content.get_children():
		if child.has_focus():
			main_focus = child

func _open():
	if main_is_open: return
	main_is_open = true
	animation_player.play('open')
	main_focus.grab_focus()
	get_tree().paused = true

func _close():
	if !main_is_open: return
	main_is_open = false
	main_focus.release_focus()
	animation_player.play_backwards('open')
	get_tree().paused = false

func _pause():
	main_focus.release_focus()
	animation_player.play("pause")

func _unpause():
	main_focus.grab_focus()
	animation_player.play_backwards("pause")

func _on_animation_main_animation_finished(anim_name: StringName) -> void:
	animation_done = true

func _on_animation_main_animation_started(anim_name: StringName) -> void:
	animation_done = false

func _on_button_credits_pressed() -> void:
	open_credits.emit()

func _on_return_btn_pressed() -> void:
	return_to_game.emit()
