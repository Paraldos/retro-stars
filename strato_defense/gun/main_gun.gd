extends Node2D

@export_enum("LEFT_TOWER", "MIDDLE_TOWER", "RIGHT_TOWER") var gun_position : String
@onready var tower: Node2D = %Tower
@export var dip = 70
@onready var attack_timer: Timer = %AttackTimer

func _ready() -> void:
	if gun_position == "LEFT_TOWER":
		tower.rotation_degrees = dip
	elif gun_position == "RIGHT_TOWER":
		tower.rotation_degrees = dip * -1

func _physics_process(delta: float) -> void:
	if Input.is_action_just_pressed("left") and gun_position == "LEFT_TOWER":
		_attack()
	if Input.is_action_just_pressed("right") and gun_position == "RIGHT_TOWER":
		_attack()
	if Input.is_action_just_pressed("up") and gun_position == "MIDDLE_TOWER":
		_attack()

func _attack():
	if !attack_timer.is_stopped(): return
	print(gun_position)
	attack_timer.start()
