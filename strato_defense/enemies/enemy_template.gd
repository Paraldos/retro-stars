extends Node2D

@onready var attack: RayCast2D = %Attack
@onready var attack_line: Line2D = %AttackLine
@onready var attack_particles: CPUParticles2D = %AttackParticles
@onready var attack_shape: CollisionShape2D = %AttackShape

var explosion_template = preload('res://strato_defense/explosion/explosion.tscn')
var speed = 300
var left_border = -128
var right_border = 1088
var row_height = 85
var rng = RandomNumberGenerator.new()
var row = 0
var time_to_cross_row = 0
var disable = false

func _ready() -> void:
	rng.randomize()
	attack.visible = false
	_initial_position()
	_move()

func _initial_position():
	if rng.randi_range(0,1) == 0:
		global_position.x = left_border
		scale.x = -1
	else:
		global_position.x = right_border

func _move():
	row += 1
	if row >= 4 or disable:
		queue_free()
	else:
		attack.visible = row == 3
		_adjust_position()
		await _tween_position_x(_get_target_pos())
		_move()

func _adjust_position():
	global_position.y = row * row_height
	if global_position.x == left_border:
		global_position.x = right_border
	else:
		global_position.x = left_border

func _get_target_pos():
	var target_pos = global_position
	if global_position.x == left_border:
		target_pos.x = right_border
	else:
		target_pos.x = left_border
	return target_pos

func _tween_position_x(target_pos):
	var tween = create_tween()
	tween.tween_property(self, 'global_position', target_pos, time_to_cross_row)
	await tween.finished
	return

func _physics_process(delta: float) -> void:
	if attack && attack.visible:
		_adjust_attack_hight()

func _adjust_attack_hight():
	if row != 3: return
	if attack.is_colliding():
		var collision_point = attack.get_collision_point()
		collision_point = to_local(collision_point)
		attack_line.points[1].y = collision_point.y +10
		attack_shape.shape.b.y = collision_point.y +10
		attack_particles.position = attack_line.points[1] + Vector2(0, 10)

func _on_hitbox_area_entered(area: Area2D) -> void:
	_spawn_explosion()
	queue_free()

func _on_attacke_area_area_entered(area: Area2D) -> void:
	disable = true
	attack.queue_free()

func _spawn_explosion():
	var explosion = explosion_template.instantiate()
	explosion.global_position = global_position
	get_tree().current_scene.add_child(explosion)
