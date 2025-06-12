extends CharacterBody2D

@onready var attack: RayCast2D = %Attack
@onready var attack_line: Line2D = %AttackLine

var speed = 300
var spawn_pos_left = 0
var spawn_pos_right = 0
var rng = RandomNumberGenerator.new()
var line = 1

func _ready() -> void:
	rng.randomize()
	attack.visible = false
	if rng.randi_range(0,1) == 0:
		global_position = spawn_pos_right
		scale.x = -1
		speed *= -1
	else:
		global_position = spawn_pos_left

func _physics_process(delta: float) -> void:
	velocity = Vector2(speed,0)
	move_and_slide()
	_adjust_attack_hight()

func _adjust_attack_hight():
	if line != 3: return
	if attack.is_colliding():
		var collision_point = attack.get_collision_point()
		collision_point = to_local(collision_point)
		attack_line.points[1].y = collision_point.y

func _on_area_2d_area_entered(area: Area2D) -> void:
	if line == 3: queue_free()
	line += 1
	_change_position()
	_enable_attack()

func _change_position():
	global_position.y = line * spawn_pos_left.y
	if global_position.x > 0:
		global_position.x = spawn_pos_left.x
	else:
		global_position.x = spawn_pos_right.x

func _enable_attack():
	if line != 3: return
	attack.visible = true

func _on_hitbox_area_entered(area: Area2D) -> void:
	queue_free()
