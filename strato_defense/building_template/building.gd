extends Area2D

@onready var torso_line: Line2D = %TorsoLine
@onready var collision_polygon: CollisionPolygon2D = %CollisionPolygon
var explosion_template = preload('res://strato_defense/explosion/explosion.tscn')

func _ready() -> void:
	torso_line.position.y -= 7
	torso_line.points = collision_polygon.polygon
	await get_tree().create_timer(0.1).timeout
	StratoDefenseData.buildings += 1

func _destroy():
	StratoDefenseData.buildings -= 1
	#
	var explosion = explosion_template.instantiate()
	explosion.global_position = global_position
	get_tree().current_scene.add_child(explosion)
	#
	queue_free()
