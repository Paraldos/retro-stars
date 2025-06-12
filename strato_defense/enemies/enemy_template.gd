extends Node2D

@onready var attack: RayCast2D = %Attack
@onready var attack_line: Line2D = %AttackLine
var speed = 300
var left_border = -128
var right_border = 1088
var row_height = 85
var rng = RandomNumberGenerator.new()
var line = 0
var time_to_cross_row = 0

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
	if line >= 3: queue_free()
	line += 1
	attack.visible = line == 3 
	_adjust_position()
	await _tween_position_x(_get_target_pos())
	_move()

func _adjust_position():
	global_position.y = line * row_height
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
	_adjust_attack_hight()

func _adjust_attack_hight():
	if line != 3: return
	if attack.is_colliding():
		var collision_point = attack.get_collision_point()
		collision_point = to_local(collision_point)
		attack_line.points[1].y = collision_point.y

func _on_hitbox_area_entered(area: Area2D) -> void:
	queue_free()
