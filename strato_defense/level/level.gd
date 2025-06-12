extends StaticBody2D

@onready var collision_polygon_2d: CollisionPolygon2D = $CollisionPolygon2D
@onready var line: Line2D = $Line

func _ready() -> void:
	line.points = collision_polygon_2d.polygon
