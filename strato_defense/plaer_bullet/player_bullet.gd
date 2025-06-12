extends CharacterBody2D

var speed = 600
var direction

func _ready() -> void:
	direction = deg_to_rad(rotation_degrees - 90)

func _physics_process(delta: float) -> void:
	velocity = Vector2(speed,0).rotated(direction)
	move_and_slide()
