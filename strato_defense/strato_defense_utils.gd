extends Node

var buildings = 0
var main_gun_intact = true
var explosion_template = preload('res://strato_defense/explosion/explosion.tscn')

func _reset():
	buildings = 0
	main_gun_intact = true

func _spawn_explosion(position):
	var explosion = explosion_template.instantiate()
	explosion.global_position = position
	get_tree().current_scene.add_child(explosion)
