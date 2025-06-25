extends Control

@onready var animation_player: AnimationPlayer = %AnimationPlayer
@onready var close_credits_btn: Button = %CloseCreditsBtn

var credits_is_open = false
var animation_done = true

signal close_credits

func _open():
	if credits_is_open: return
	credits_is_open = true
	animation_player.play("open")
	close_credits_btn.grab_focus()

func _close():
	if !credits_is_open: return
	credits_is_open = false
	animation_player.play_backwards("open")
	close_credits_btn.release_focus()

func _on_animation_credits_animation_finished(anim_name: StringName) -> void:
	animation_done = true

func _on_animation_credits_animation_started(anim_name: StringName) -> void:
	animation_done = false

func _on_close_credits_btn_pressed() -> void:
	close_credits.emit()
