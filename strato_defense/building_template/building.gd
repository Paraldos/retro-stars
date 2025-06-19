extends Area2D

@onready var torso_line: Line2D = %TorsoLine
@onready var collision_polygon: CollisionPolygon2D = %CollisionPolygon
var explosion_template = preload('res://strato_defense/explosion/explosion.tscn')

func _ready() -> void:
	torso_line.position.y -= 7
	torso_line.points = collision_polygon.polygon

func _on_area_entered(area: Area2D) -> void:
	_spawn_explosion()
	queue_free()

func _spawn_explosion():
	var explosion = explosion_template.instantiate()
	explosion.global_position = global_position
	get_tree().current_scene.add_child(explosion)
