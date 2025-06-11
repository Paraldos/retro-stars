extends CharacterBody2D

var speed = 300
var spawn_pos_left = 0
var spawn_pos_right = 0
var rng = RandomNumberGenerator.new()

func _ready() -> void:
	rng.randomize()
	if rng.randi_range(0,1) == 0:
		global_position = spawn_pos_right
		scale.x = -1
		speed *= -1
	else:
		global_position = spawn_pos_left

func _physics_process(delta: float) -> void:
	velocity = Vector2(speed,0)
	move_and_slide()

func _on_area_2d_area_entered(area: Area2D) -> void:
	if global_position.y > 220: queue_free()
	global_position.y += 85
	if global_position.x > 0:
		global_position.x = spawn_pos_left.x
	else:
		global_position.x = spawn_pos_right.x

func _on_hitbox_area_entered(area: Area2D) -> void:
	queue_free()
