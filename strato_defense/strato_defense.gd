extends CanvasLayer

@onready var game_over_screen: CanvasLayer = %GameOverScreen

var buildings = 0
var main_gun_intact = true
var points = 0
var explosion_template = preload('res://strato_defense/explosion/explosion.tscn')

func _ready() -> void:
	Utils.strato_defense = self
	SignalBus.building_destroyed.connect(_on_building_destroyed)
	_reset()

func _on_building_destroyed():
	if buildings == 0:
		game_over_screen._open()

func _reset():
	buildings = 0
	main_gun_intact = true
	points = 0

func _add_points(value):
	points += value
	SignalBus.update_points.emit()

func _spawn_explosion(position):
	var explosion = explosion_template.instantiate()
	explosion.global_position = position
	get_tree().current_scene.add_child(explosion)
