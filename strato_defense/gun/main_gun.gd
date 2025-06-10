extends Node2D

@onready var tower: Node2D = %Tower
@onready var bullet_spawn_point: Node2D = %BulletSpawnPoint
@export_enum("LEFT_TOWER", "MIDDLE_TOWER", "RIGHT_TOWER") var gun_position : String
@export var dip = 70
var player_bullet = preload("res://strato_defense/plaer_bullet/player_bullet.tscn")
var recoil_direction: Vector2
var recoil_amount = 15

func _ready() -> void:
	if gun_position == "LEFT_TOWER":
		tower.rotation_degrees = dip
	elif gun_position == "RIGHT_TOWER":
		tower.rotation_degrees = dip * -1
	var adjusted_rotation = deg_to_rad(tower.rotation_degrees - 90)
	recoil_direction = Vector2(cos(adjusted_rotation), sin(adjusted_rotation)).normalized()

func _attack():
	_spawn_bullet()
	_recoil()

func _spawn_bullet():
	var bullet = player_bullet.instantiate()
	bullet.global_position = bullet_spawn_point.global_position
	bullet.rotation_degrees = tower.rotation_degrees
	get_tree().current_scene.add_child(bullet)

func _recoil():
	var initial_position = tower.position
	var recoil_position = initial_position - recoil_direction * recoil_amount
	tower.position = recoil_position
	var tween = create_tween()
	tween.tween_property(tower, "position", initial_position, 0.3)  # Return to original position
