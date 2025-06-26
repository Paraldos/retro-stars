extends CanvasLayer

@onready var animation_player: AnimationPlayer = %AnimationPlayer
@onready var label_points: Label = %LabelPoints
@onready var restart_button: Button = %RestartButton

func _open():
	get_tree().paused = true
	label_points.text = "Points: %s" % Utils.strato_defense.points
	Overlay._open()
	animation_player.play("open")
	restart_button.grab_focus()

func _on_restart_button_pressed() -> void:
	SceneChanger._reset_current_scene()
