extends Area2D

@onready var torso_line: Line2D = %TorsoLine
@onready var collision_polygon: CollisionPolygon2D = %CollisionPolygon

func _ready() -> void:
	torso_line.position.y -= 7
	torso_line.points = collision_polygon.polygon
	await get_tree().create_timer(0.1).timeout
	StratoDefenseUtils.buildings += 1

func _destroy():
	StratoDefenseUtils.buildings -= 1
	StratoDefenseUtils._spawn_explosion(global_position)
	queue_free()
