extends Node2D

@export_enum("LEFT_TOWER", "MIDDLE_TOWER", "RIGHT_TOWER") var gun_position : String
@onready var tower: Node2D = %Tower
@export var dip = 70

func _ready() -> void:
	if gun_position == "LEFT_TOWER":
		tower.rotation_degrees = dip
	elif gun_position == "RIGHT_TOWER":
		tower.rotation_degrees = dip * -1
