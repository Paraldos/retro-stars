extends CanvasLayer

@onready var rect: ColorRect = %Rect
@onready var animation_player: AnimationPlayer = %AnimationPlayer
var is_playing = false

func _ready() -> void:
	rect.mouse_filter = Control.MOUSE_FILTER_IGNORE

func _start_scene_chagen():
	is_playing = true
	get_tree().paused = true
	rect.mouse_filter = Control.MOUSE_FILTER_STOP
	animation_player.play("open")
	await animation_player.animation_finished
	return true

func _end_scene_change():
	animation_player.play_backwards("open")
	Overlay._close()
	await animation_player.animation_finished
	rect.mouse_filter = Control.MOUSE_FILTER_IGNORE
	get_tree().paused = false
	is_playing = false

func _change_scene(path_to_new_scene):
	await _start_scene_chagen()
	get_tree().change_scene_to_file(path_to_new_scene)
	_end_scene_change()

func _reset_current_scene():
	await _start_scene_chagen()
	get_tree().reload_current_scene()
	_end_scene_change()
