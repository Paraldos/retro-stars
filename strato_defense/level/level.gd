extends StaticBody2D

@onready var collision_polygon_2d: CollisionPolygon2D = $CollisionPolygon2D
@onready var background_polygon: Polygon2D = $BackgroundPolygon
@onready var line: Line2D = $Line

func _ready() -> void:
	background_polygon.polygon = collision_polygon_2d.polygon
	line.points = collision_polygon_2d.polygon
