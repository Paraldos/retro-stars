extends CanvasLayer

@onready var points_label: Label = %PointsLabel

func _ready() -> void:
	SignalBus.update_points.connect(_on_update_points)

func _on_update_points():
	points_label.text = "Points: %s" % StratoDefenseUtils.points
