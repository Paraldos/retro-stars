extends Area2D

@onready var torso_line: Line2D = %TorsoLine
@onready var collision_polygon: CollisionPolygon2D = %CollisionPolygon

func _ready() -> void:
	torso_line.position.y -= 7
	torso_line.points = collision_polygon.polygon

func _on_area_entered(area: Area2D) -> void:
	queue_free()
