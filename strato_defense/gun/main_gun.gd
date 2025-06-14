extends Node2D

@onready var tower: Node2D = %Tower
@onready var bullet_spawn_point: Node2D = %BulletSpawnPoint
@onready var audio_stream_player: AudioStreamPlayer2D = %AudioStreamPlayer
@export_enum("LEFT_TOWER", "MIDDLE_TOWER", "RIGHT_TOWER") var gun_position : String
@export var dip = 70
var player_bullet = preload("res://strato_defense/plaer_bullet/player_bullet.tscn")
var recoil_direction: Vector2
var recoil_amount = 15
var rng = RandomNumberGenerator.new()

func _ready() -> void:
	rng.randomize()
	_setup_gun_rotation()
	_setup_recoil_direction()

func _setup_gun_rotation():
	if gun_position == "LEFT_TOWER":
		tower.rotation_degrees = dip
	elif gun_position == "RIGHT_TOWER":
		tower.rotation_degrees = dip * -1

func _setup_recoil_direction():
	var adjusted_rotation = deg_to_rad(tower.rotation_degrees - 90)
	recoil_direction = Vector2(cos(adjusted_rotation), sin(adjusted_rotation)).normalized()

func _attack():
	_turn()
	_spawn_bullet()
	_recoil()
	_sound()

func _spawn_bullet():
	var bullet = player_bullet.instantiate()
	bullet.global_position = bullet_spawn_point.global_position
	bullet.rotation_degrees = tower.rotation_degrees
	get_tree().current_scene.add_child(bullet)

func _sound():
	audio_stream_player.pitch_scale = rng.randf_range(0.8, 1.2)
	audio_stream_player.play()

func _turn():
	var offset = 2
	var init_rotation = tower.rotation_degrees
	tower.rotation_degrees = init_rotation + rng.randf_range(-offset, offset)
	var tween = create_tween()
	tween.tween_property(tower, "rotation_degrees", init_rotation, 0.3)

func _recoil():
	var initial_pos = tower.position
	tower.position = initial_pos - recoil_direction * recoil_amount
	var tween = create_tween()
	tween.tween_property(tower, "position", initial_pos, 0.3)
