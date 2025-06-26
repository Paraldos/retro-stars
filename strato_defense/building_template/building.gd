extends Area2D

@onready var torso_line: Line2D = %TorsoLine
@onready var collision_polygon: CollisionPolygon2D = %CollisionPolygon
@onready var background_polygon: Polygon2D = %BackgroundPolygon

func _ready() -> void:
	position.y -= 7
	background_polygon.polygon = collision_polygon.polygon
	torso_line.points = collision_polygon.polygon
	await get_tree().create_timer(0.1).timeout
	Utils.strato_defense.buildings += 1

func _destroy():
	Utils.strato_defense.buildings -= 1
	Utils.strato_defense._spawn_explosion(global_position)
	SignalBus.building_destroyed.emit()
	visible = false
	collision_polygon.call_deferred('set_disabled', true)
