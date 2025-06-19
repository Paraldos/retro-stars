class_name SoundEffect
extends Node2D

@export var pitch_range = 0.1
var rng = RandomNumberGenerator.new()

func _ready() -> void:
	rng.randomize()
	for child in get_children():
		child.bus = &"SFX"

func _play():
	var effect_number = rng.randi_range(0, get_child_count() -1)
	get_children()[effect_number].pitch_scale = rng.randf_range(1.0 - pitch_range, 1.0 + pitch_range)
	get_children()[effect_number].play()

func _stop():
	for child in get_children():
		child.stop()
